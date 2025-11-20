import 'package:flutter/material.dart';

import '../../../presentations/configs/duration.dart';

/// A widget that displays text with a typewriter animation effect.
/// The text appears character-by-character without any cursor.
class TypewriterText extends StatefulWidget {
  /// The full text to be displayed.
  final String text;

  /// Style of the text.
  final TextStyle? style;

  /// Duration for typing each character.
  final Duration speed;

  /// Delay before the typing animation starts.
  final Duration startDelay;

  /// Optional external AnimationController (useful for synchronizing with other animations).
  final AnimationController? controller;

  const TypewriterText(
    this.text, {
    super.key,
    this.style,
    this.speed = duration300,
    this.startDelay = duration2000,
    this.controller,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<int> _charAnimation;

  bool get _hasExternalController => widget.controller != null;

  @override
  void initState() {
    super.initState();

    _controller = _hasExternalController
        ? widget.controller!
        : AnimationController(vsync: this);

    _setupAnimation();

    // Auto-start only if we own the controller
    if (!_hasExternalController) {
      Future.delayed(widget.startDelay, () {
        if (mounted) {
          _controller.duration = widget.speed * widget.text.length;
          _controller.forward(from: 0);
        }
      });
    }
  }

  void _setupAnimation() {
    final int charCount = widget.text.length;

    // The actual typing part (after the start delay) should be linear
    _charAnimation = IntTween(begin: 0, end: charCount).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear, // typing is always uniform speed
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text ||
        widget.speed != oldWidget.speed ||
        widget.startDelay != oldWidget.startDelay ||
        widget.controller != oldWidget.controller) {
      _setupAnimation();

      if (!_hasExternalController) {
        _controller
          ..reset()
          ..duration = widget.speed * widget.text.length;
        Future.delayed(widget.startDelay, () {
          if (mounted) _controller.forward(from: 0);
        });
      }
    }
  }

  @override
  void dispose() {
    if (!_hasExternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final int displayedChars = _charAnimation.value.clamp(
          0,
          widget.text.length,
        );
        final String displayedText = widget.text.substring(0, displayedChars);

        return Text(displayedText, style: widget.style);
      },
    );
  }
}
