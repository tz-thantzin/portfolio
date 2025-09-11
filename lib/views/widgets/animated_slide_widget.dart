import 'package:flutter/material.dart';

class AnimatedSlideWidget extends StatelessWidget {
  final Animation<Offset> animation;
  final Animation<double> fadeAnimation;
  final Widget child;

  const AnimatedSlideWidget({
    required this.animation,
    required this.fadeAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(position: animation, child: child),
    );
  }
}
