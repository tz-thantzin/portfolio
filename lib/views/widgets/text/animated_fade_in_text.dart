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
  final AnimationController? controller; // optional external controller

  const AnimatedFadeInText(
    this.text, {
    super.key,
    this.style,
    this.duration = duration500,
    this.delay = Duration.zero,
    this.curve = Curves.easeIn,
    this.controller,
  });

  @override
  State<AnimatedFadeInText> createState() => _AnimatedFadeInTextState();
}

class _AnimatedFadeInTextState extends State<AnimatedFadeInText>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final bool _ownsController; // track ownership

  @override
  void initState() {
    super.initState();

    // Use external controller if provided, otherwise create one
    if (widget.controller != null) {
      _controller = widget.controller!;
      _ownsController = false;
    } else {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      _ownsController = true;
    }

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _detectVisibility(VisibilityInfo info) {
    if (info.visibleFraction > 0.45) {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Text(widget.text, style: widget.style),
    ).addVisibilityDetector(onDetectVisibility: _detectVisibility);
  }
}
