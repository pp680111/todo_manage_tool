import 'dart:async';
import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/services.dart';
import 'package:todo_manage/widget/platform/windows/windows_configuration.dart';
import 'package:window_manager/window_manager.dart';

class TaskBubbleWindowService {
  TaskBubbleWindowService(this.ownerWindow);

  static const String windowRole = 'task_bubble';
  static const String readyMethod = 'bubble_ready';
  static const String refreshMethod = 'refresh_tasks';
  static const String moveMethod = 'move_bubble';
  static const String openMainMethod = 'open_main_window';
  static const String hiddenMethod = 'bubble_hidden';
  static const String hideReasonBlur = 'blur';

  /// When the bubble hides itself on blur, the click that stole its focus is
  /// often the same pet tap whose trailing edge would toggle it open again.
  static const Duration _blurToggleSuppression = Duration(milliseconds: 350);

  /// If the bubble engine never reports ready (e.g. it dies mid-boot), stop
  /// waiting after this long and present best-effort so clicks never hang.
  static const Duration _readyFallbackTimeout = Duration(seconds: 20);

  static const Size bubbleSize = Size(380, 360);

  final WindowController ownerWindow;

  WindowController? _bubbleWindow;
  Future<WindowController>? _creatingBubble;
  Completer<void>? _bubbleReady;
  Timer? _readyFallbackTimer;

  /// In-flight show; repeated clicks while the bubble engine is still booting
  /// join this future instead of being dropped.
  Future<void>? _showing;

  /// Bumped by every hide; an in-flight show bails out if the count changed
  /// while it was waiting, so "open main window" during a cold boot wins
  /// immediately instead of queueing behind the boot.
  int _hideCount = 0;

  Future<void> Function()? _onOpenMainWindow;
  bool _visible = false;
  bool _followInFlight = false;
  bool _followPending = false;
  DateTime? _lastBlurHiddenAt;

  Future<void> initialize({
    required Future<void> Function() onOpenMainWindow,
  }) async {
    _onOpenMainWindow = onOpenMainWindow;
    await ownerWindow.setWindowMethodHandler(_handleWindowMethod);
  }

  Future<void> toggle() async {
    if (_lastBlurHiddenAt != null &&
        DateTime.now().difference(_lastBlurHiddenAt!) <
            _blurToggleSuppression) {
      // The blur from this very click already hid the bubble; a reopen here
      // would make the pet feel unable to close it.
      return;
    }
    if (_visible) {
      await hide();
    } else {
      await show();
    }
  }

  /// Spawns the bubble window hidden ahead of the first click and waits for
  /// the child engine's ready handshake, so showing the bubble later only
  /// needs move/refresh/show messages instead of a full Flutter engine cold
  /// start.
  Future<void> prewarm() async {
    await _ensureBubbleWindow();
  }

  /// Clicks that arrive while a show is still presenting (engine boot, move/
  /// refresh round-trips) join the in-flight show instead of being dropped,
  /// so the bubble appears as soon as it can.
  Future<void> show() {
    return _showing ??= _showNow().whenComplete(() => _showing = null);
  }

  Future<void> _showNow() async {
    final hideCount = _hideCount;
    final bubbleWindow = await _ensureBubbleWindow();
    final position = await _calculateBubblePosition();
    if (hideCount != _hideCount) return;
    await bubbleWindow.invokeMethod<void>(moveMethod, {
      'x': position.dx,
      'y': position.dy,
    });
    await bubbleWindow.invokeMethod<void>(refreshMethod);
    if (hideCount != _hideCount) return;
    await bubbleWindow.show();
    _visible = true;
  }

  /// Hiding never queues behind a show that is waiting for the bubble engine
  /// to boot (e.g. double-clicking the pet for the main window right after a
  /// first click). The native hide works on a booting engine, so apply it
  /// right away; a show that has not presented yet notices via [_hideCount].
  Future<void> hide() async {
    _hideCount++;
    final bubbleWindow = _bubbleWindow;
    if (bubbleWindow != null) await bubbleWindow.hide();
    _visible = false;
  }

  /// Creates the bubble engine once and waits until the child window reports
  /// itself ready (method handler registered, first frame painted, initial
  /// task query settled), so presenting never shows a blank window and no
  /// move/refresh message is sent into a still-booting engine.
  Future<WindowController> _ensureBubbleWindow() {
    final bubbleWindow = _bubbleWindow;
    if (bubbleWindow != null) {
      return Future.value(bubbleWindow);
    }
    return _creatingBubble ??= _createBubbleWindow()
        .whenComplete(() => _creatingBubble = null);
  }

  Future<WindowController> _createBubbleWindow() async {
    final position = await _calculateBubblePosition();
    final ready = Completer<void>();
    _bubbleReady = ready;
    _readyFallbackTimer = Timer(_readyFallbackTimeout, () {
      if (!ready.isCompleted) ready.complete();
    });
    try {
      final bubbleWindow = await WindowController.create(
        WindowConfiguration(
          hiddenAtLaunch: true,
          arguments: jsonEncode({
            'role': windowRole,
            'ownerWindowId': ownerWindow.windowId,
            'x': position.dx,
            'y': position.dy,
          }),
        ),
      );
      _bubbleWindow = bubbleWindow;
      await ready.future;
      return bubbleWindow;
    } finally {
      _readyFallbackTimer?.cancel();
      _readyFallbackTimer = null;
      if (identical(_bubbleReady, ready)) {
        _bubbleReady = null;
      }
    }
  }

  /// Keeps the bubble aligned with the pet window while it is being dragged.
  ///
  /// Window move events fire at high frequency, so only one position sync is
  /// in flight at a time; further events coalesce into a single trailing send
  /// so the bubble always ends up at the pet's latest position.
  Future<void> followPet() async {
    if (!_visible) return;
    if (_followInFlight) {
      _followPending = true;
      return;
    }
    _followInFlight = true;
    try {
      do {
        _followPending = false;
        final position = await _calculateBubblePosition();
        final bubbleWindow = _bubbleWindow;
        if (!_visible || bubbleWindow == null) return;
        await bubbleWindow.invokeMethod<void>(moveMethod, {
          'x': position.dx,
          'y': position.dy,
        });
      } while (_followPending);
    } finally {
      _followInFlight = false;
    }
  }

  Future<Offset> _calculateBubblePosition() async {
    final petPosition = await windowManager.getPosition();
    return Offset(
      petPosition.dx +
          (WindowsConfiguration.petSize.width - bubbleSize.width) / 2,
      petPosition.dy - bubbleSize.height + 12,
    );
  }

  Future<dynamic> _handleWindowMethod(MethodCall call) async {
    switch (call.method) {
      case readyMethod:
        final ready = _bubbleReady;
        if (ready != null && !ready.isCompleted) ready.complete();
        return null;
      case hiddenMethod:
        _visible = false;
        final arguments = call.arguments;
        if (arguments is Map && arguments['reason'] == hideReasonBlur) {
          _lastBlurHiddenAt = DateTime.now();
        }
        return null;
      case openMainMethod:
        await hide();
        await _onOpenMainWindow?.call();
        return null;
      default:
        throw MissingPluginException('Unknown window method: ${call.method}');
    }
  }
}
