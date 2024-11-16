
import 'dart:async';

import 'package:flutter/material.dart';

enum _ProgressState {
  loading,
  success,
  error
}

class _ProgressEvent {
  _ProgressState state;
  String? message;

  _ProgressEvent({
    required this.state,
    this.message
  });
}

class ProgressingOverlay {
  static OverlayEntry? _overlayEntry;
  static final StreamController<_ProgressEvent> _eventStream = StreamController<_ProgressEvent>.broadcast();

  static void show(BuildContext context, [String? message]) {
    if (_overlayEntry != null) {
      return;
    }

    final overlay = OverlayEntry(
      builder: (context) => StreamBuilder<_ProgressEvent>(
        stream: _eventStream.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return Material(
            color: Colors.grey.withOpacity(0.5),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: _buildOverlayContent(snapshot.data!),
              ),
            ),
          );
        },
      )
    );

    _overlayEntry = overlay;
    Overlay.of(context).insert(overlay);
  }

  static Future<void> success(BuildContext context, [String? message]) async {
    if (_overlayEntry == null) {
      return;
    }

    _eventStream.add(_ProgressEvent(state: _ProgressState.success, message: message));

    return Future.delayed(const Duration(milliseconds: 500)).then((_) {
      _hide();
    });
  }

  static Future<void> error(BuildContext context, [String? message]) async {
    if (_overlayEntry == null) {
      return;
    }

    _eventStream.add(_ProgressEvent(state: _ProgressState.error, message: message));

    return Future.delayed(const Duration(milliseconds: 500)).then((_) {
      _hide();
    });
  }

  static void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static Widget _buildOverlayContent(_ProgressEvent event) {
    Widget stateLogo;
    switch (event.state) {
      case _ProgressState.loading:
        stateLogo = const CircularProgressIndicator();
        break;
      case _ProgressState.success:
        stateLogo = const Icon(Icons.check_circle, color: Colors.green);
        break;
      case _ProgressState.error:
        stateLogo = const Icon(Icons.error, color: Colors.red);
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        if (event.message != null) ...[
          const SizedBox(height: 16),
          Text(event.message ?? ""),
        ]
      ],
    );
  }
}