import 'package:flutter/material.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/duration.dart';

class AnimatedFadeWidget extends StatefulWidget {
  final AnimationController? controller;
  final Widget child;
  final double start;
  final double end;
  final Duration duration;
  final Duration delay;

  const AnimatedFadeWidget({
    super.key,
    this.controller,
    required this.child,
    this.duration = duration1000,
    this.start = 0.0,
    this.end = 1,
    this.delay = duration500,
  });

  @override
  State<AnimatedFadeWidget> createState() => _AnimatedFadeWidgetState();
}

class _AnimatedFadeWidgetState extends State<AnimatedFadeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
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
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Material(
            color: kTransparent,
            child: IgnorePointer(
              ignoring: _fadeAnimation.value < 0.01,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
