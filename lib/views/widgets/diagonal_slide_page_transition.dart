import 'package:flutter/material.dart';

class DiagonalSlideTransition extends AnimatedWidget {
  const DiagonalSlideTransition({
    super.key,
    required this.controller,
    required this.height,
    required this.width,
    this.index = 0,
    this.color = Colors.black,
    required this.slideInterval,
    this.curve = Curves.easeInOut,
  }) : super(listenable: controller);

  final AnimationController controller;
  final double height;
  final double width;
  final int index;
  final Color color;
  final Interval slideInterval;
  final Curve curve;

  Animation<double> get _slideAnimation => Tween<double>(
    begin: -1.0,
    end: 0.0,
  ).animate(CurvedAnimation(parent: controller, curve: slideInterval));

  Animation<double> get _scaleAnimation =>
      Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(slideInterval.begin, slideInterval.end, curve: curve),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        _slideAnimation.value * width,
        _slideAnimation.value * height,
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
