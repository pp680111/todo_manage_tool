import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/services.dart';
import 'package:todo_manage/widget/platform/windows/windows_configuration.dart';
import 'package:window_manager/window_manager.dart';

class TaskBubbleWindowService {
  TaskBubbleWindowService(this.ownerWindow);

  static const String windowRole = 'task_bubble';
  static const String refreshMethod = 'refresh_tasks';
  static const String moveMethod = 'move_bubble';
  static const String openMainMethod = 'open_main_window';
  static const String hiddenMethod = 'bubble_hidden';
  static const String hideReasonBlur = 'blur';

  /// When the bubble hides itself on blur, the click that stole its focus is
  /// often the same pet tap whose trailing edge would toggle it open again.
  static const Duration _blurToggleSuppression = Duration(milliseconds: 350);

  static const Size bubbleSize = Size(380, 360);

  final WindowController ownerWindow;

  WindowController? _bubbleWindow;
  Future<WindowController>? _creatingBubble;
  Future<void> Function()? _onOpenMainWindow;
  bool _visible = false;
  bool _changingVisibility = false;
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
    if (_changingVisibility) return;
    if (!_visible &&
        _lastBlurHiddenAt != null &&
        DateTime.now().difference(_lastBlurHiddenAt!) <
            _blurToggleSuppression) {
      // The blur from this very click already hid the bubble; a reopen here
      // would make the pet feel unable to close it.
      return;
    }
    _changingVisibility = true;
    try {
      if (_visible) {
        await hide();
      } else {
        await show();
      }
    } finally {
      _changingVisibility = false;
    }
  }

  /// Spawns the bubble window hidden ahead of the first click, so showing
  /// the bubble later only needs move/refresh/show messages instead of a
  /// full Flutter engine cold start.
  Future<void> prewarm() async {
    await _ensureBubbleWindow(autoShow: false);
  }

  Future<void> show() async {
    // A window created inline with autoShow=true shows itself once its engine
    // finishes booting; anything else needs an explicit show here.
    final createsInline = _bubbleWindow == null && _creatingBubble == null;
    final bubbleWindow = await _ensureBubbleWindow(autoShow: true);
    if (!createsInline) {
      final position = await _calculateBubblePosition();
      await bubbleWindow.invokeMethod<void>(moveMethod, {
        'x': position.dx,
        'y': position.dy,
      });
      await bubbleWindow.invokeMethod<void>(refreshMethod);
      await bubbleWindow.show();
    }
    _visible = true;
  }

  Future<WindowController> _ensureBubbleWindow({required bool autoShow}) {
    final bubbleWindow = _bubbleWindow;
    if (bubbleWindow != null) {
      return Future.value(bubbleWindow);
    }
    return _creatingBubble ??= _createBubbleWindow(autoShow: autoShow)
        .whenComplete(() => _creatingBubble = null);
  }

  Future<WindowController> _createBubbleWindow({required bool autoShow}) async {
    final position = await _calculateBubblePosition();
    final bubbleWindow = await WindowController.create(
      WindowConfiguration(
        hiddenAtLaunch: true,
        arguments: jsonEncode({
          'role': windowRole,
          'ownerWindowId': ownerWindow.windowId,
          'x': position.dx,
          'y': position.dy,
          'autoShow': autoShow,
        }),
      ),
    );
    _bubbleWindow = bubbleWindow;
    return bubbleWindow;
  }

  Future<void> hide() async {
    final bubbleWindow = _bubbleWindow;
    if (bubbleWindow != null) await bubbleWindow.hide();
    _visible = false;
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
