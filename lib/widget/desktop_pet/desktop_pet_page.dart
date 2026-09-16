import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DesktopPetPage extends StatefulWidget {
  const DesktopPetPage({
    super.key,
    required this.onOpenMainWindow,
    required this.onToggleTaskBubble,
  });

  final Future<void> Function() onOpenMainWindow;
  final Future<void> Function() onToggleTaskBubble;

  @override
  State<DesktopPetPage> createState() => _DesktopPetPageState();
}

class _DesktopPetPageState extends State<DesktopPetPage> {
  bool _dragging = false;
  DateTime? _lastTapAt;
  Future<void>? _bubbleToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            key: const ValueKey('desktop-pet-icon'),
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) => _dragging = false,
            onTapUp: (_) => _handlePointerTap(),
            onTapCancel: () => _dragging = false,
            onPanStart: (_) {
              _dragging = true;
              windowManager.startDragging();
            },
            child: Image.asset(
              'images/desktop_pet.png',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePointerTap() async {
    if (_dragging) return;

    final now = DateTime.now();
    final lastTapAt = _lastTapAt;
    if (lastTapAt != null &&
        now.difference(lastTapAt) < const Duration(milliseconds: 350)) {
      _lastTapAt = null;
      await _bubbleToggle;
      await widget.onOpenMainWindow();
      return;
    }

    _lastTapAt = now;
    final toggle = widget.onToggleTaskBubble();
    _bubbleToggle = toggle;
    await toggle;
  }
}
