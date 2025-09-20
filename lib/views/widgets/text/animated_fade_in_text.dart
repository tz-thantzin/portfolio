import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedFadeInText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const AnimatedFadeInText(
    this.text, {
    super.key,
    this.style,
    this.duration = duration500,
    this.delay = Duration.zero,
    this.curve = Curves.easeIn,
  });

  @override
  State<AnimatedFadeInText> createState() => _AnimatedFadeInTextState();
}

class _AnimatedFadeInTextState extends State<AnimatedFadeInText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _detectVisibility(VisibilityInfo info) {
    if (info.visibleFraction > 0.45) {
      // Add optional delay before starting animation
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
    // else {
    //   if (_controller.isCompleted) {
    //     _controller.reset();
    //   }
    //   if (_controller.isCompleted) {
    //     _controller.reset();
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Text(widget.text, style: widget.style),
    ).addVisibilityDetector(onDetectVisibility: _detectVisibility);
  }
}
