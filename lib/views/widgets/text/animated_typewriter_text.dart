import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration speed;
  final Duration startDelay;
  final TextStyle? style;
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
  late AnimationController _controller;
  late Animation<int> _charCount;
  bool _isExternalController = false;

  @override
  void initState() {
    super.initState();

    final totalDuration = widget.speed * widget.text.length + widget.startDelay;

    if (widget.controller != null) {
      _controller = widget.controller!;
      _isExternalController = true;
    } else {
      _controller = AnimationController(vsync: this, duration: totalDuration);
    }

    _setupAnimation(totalDuration);

    if (!_isExternalController) {
      _controller.forward();
    }
  }

  void _setupAnimation(Duration totalDuration) {
    _charCount = StepTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.startDelay.inMilliseconds / totalDuration.inMilliseconds,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      final totalDuration =
          widget.speed * widget.text.length + widget.startDelay;

      if (!_isExternalController) {
        _controller.dispose();
        _controller = AnimationController(vsync: this, duration: totalDuration)
          ..forward();
      }

      _setupAnimation(totalDuration);
    }
  }

  @override
  void dispose() {
    if (!_isExternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charCount,
      builder: (context, child) {
        final count = _charCount.value;
        final displayText = widget.text.substring(0, count);
        final finished = count == widget.text.length;

        return Text(
          finished ? displayText : '$displayText|',
          style: widget.style,
        );
      },
    );
  }
}
