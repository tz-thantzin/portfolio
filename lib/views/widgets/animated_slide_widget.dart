import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';

enum SlideDirection { up, down, left, right }

class AnimatedSlideWidget extends StatefulWidget {
  final AnimationController? controller;
  final Widget child;
  final double start;
  final double end;
  final Duration duration;
  final Duration delay;
  final SlideDirection direction;

  const AnimatedSlideWidget({
    super.key,
    this.controller,
    required this.child,
    this.duration = duration1000,
    this.start = 0.0,
    this.end = 1.0,
    this.delay = Duration.zero,
    this.direction = SlideDirection.up,
  });

  @override
  State<AnimatedSlideWidget> createState() => _AnimatedSlideWidgetState();
}

class _AnimatedSlideWidgetState extends State<AnimatedSlideWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      _ownsController = true;

      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller = widget.controller!;
    }

    _setupAnimations();
  }

  void _setupAnimations() {
    // Slide offset based on direction
    Offset beginOffset;
    switch (widget.direction) {
      case SlideDirection.up:
        beginOffset = const Offset(0, 1);
        break;
      case SlideDirection.down:
        beginOffset = const Offset(0, -1);
        break;
      case SlideDirection.left:
        beginOffset = const Offset(1, 0);
        break;
      case SlideDirection.right:
        beginOffset = const Offset(-1, 0);
        break;
    }

    _slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(widget.start, widget.end, curve: Curves.easeOut),
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(widget.start, widget.end, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      alwaysIncludeSemantics: false,
      child: SlideTransition(
        position: _slideAnimation,
        transformHitTests: true,
        child: AnimatedBuilder(
          animation: _slideAnimation,
          builder: (context, child) {
            return IgnorePointer(
              ignoring: _slideAnimation.value.dy > 0.99,
              child: child,
            );
          },
          child: Material(color: Colors.transparent, child: widget.child),
        ),
      ),
    );
  }
}
