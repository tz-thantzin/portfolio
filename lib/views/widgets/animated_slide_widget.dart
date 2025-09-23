import 'package:flutter/material.dart';

enum SlideDirection { downToUp, upToDown, rightToLeft, leftToRight }

class AnimatedSlideWidget extends StatefulWidget {
  final AnimationController? controller;
  final Widget child;

  /// Start of the animation (0.0 - 1.0)
  final double start;

  /// End of the animation (0.0 - 1.0)
  final double end;

  /// Optional: how far the widget slides (0.0 = no movement, 1.0 = full offset)
  final double beginOffset;

  /// Optional: end offset magnitude (default 0.0, so slides back to original position)
  final double endOffset;

  final Duration duration;
  final Duration delay;
  final SlideDirection direction;
  final bool reverse;
  final bool fade; // enable/disable fade

  const AnimatedSlideWidget({
    super.key,
    this.controller,
    required this.child,
    this.start = 0.0,
    this.end = 1.0,
    this.beginOffset = 0.3, // default slide distance
    this.endOffset = 0.0, // default end offset
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.direction = SlideDirection.downToUp,
    this.reverse = false,
    this.fade = true,
  });

  @override
  State<AnimatedSlideWidget> createState() => _AnimatedSlideWidgetState();
}

class _AnimatedSlideWidgetState extends State<AnimatedSlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _ownsController = false;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      _ownsController = true;

      if (widget.delay > Duration.zero) {
        Future.delayed(widget.delay, () {
          if (mounted) _controller.forward();
        });
      } else {
        _controller.forward();
      }
    } else {
      _controller = widget.controller!;
    }

    _setupAnimations();
  }

  void _setupAnimations() {
    // Determine the slide offset direction
    Offset directionOffset;
    switch (widget.direction) {
      case SlideDirection.downToUp:
        directionOffset = Offset(0, widget.beginOffset);
        break;
      case SlideDirection.upToDown:
        directionOffset = Offset(0, -widget.beginOffset);
        break;
      case SlideDirection.rightToLeft:
        directionOffset = Offset(widget.beginOffset, 0);
        break;
      case SlideDirection.leftToRight:
        directionOffset = Offset(-widget.beginOffset, 0);
        break;
    }

    // Swap begin/end if reverse is true
    final begin = widget.reverse ? Offset(0, 0) : directionOffset;
    final end = widget.reverse
        ? directionOffset
        : Offset(
            widget.direction == SlideDirection.rightToLeft ||
                    widget.direction == SlideDirection.leftToRight
                ? widget.endOffset * (directionOffset.dx.isNegative ? -1 : 1)
                : 0,
            widget.direction == SlideDirection.upToDown ||
                    widget.direction == SlideDirection.downToUp
                ? widget.endOffset * (directionOffset.dy.isNegative ? -1 : 1)
                : 0,
          );

    _slideAnimation = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.start.clamp(0.0, 1.0),
          widget.end.clamp(0.0, 1.0),
          curve: Curves.easeOut,
        ),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.start.clamp(0.0, 1.0),
          widget.end.clamp(0.0, 1.0),
          curve: Curves.easeIn,
        ),
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
    Widget animatedChild = SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );

    // Wrap with fade only if fade = true
    if (widget.fade) {
      animatedChild = FadeTransition(
        opacity: _fadeAnimation,
        child: animatedChild,
      );
    }

    return animatedChild;
  }
}
