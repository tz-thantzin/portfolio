import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/extensions.dart';

class LoadingSliderTransition extends AnimatedWidget {
  const LoadingSliderTransition({
    super.key,
    required this.controller,
    this.index = 0,
    required this.height,
    required this.width,
    this.visibleBoxAnimation,
    this.invisibleBoxAnimation,
    this.boxColor = kBlack,
    this.coverColor = kWhite,
    required this.slideInterval,
    this.visibleBoxCurve = Curves.easeInOut,
    this.invisibleBoxCurve = Curves.easeInOut,
  }) : super(listenable: controller);

  final AnimationController controller;
  final double height;
  final int index;
  final double width;
  final Color boxColor;
  final Color coverColor;
  final Curve visibleBoxCurve;
  final Curve invisibleBoxCurve;
  final Interval slideInterval;
  final Animation<double>? visibleBoxAnimation;
  final Animation<double>? invisibleBoxAnimation;

  /// Black box sliding from left to right
  Animation<double> get visibleAnimation =>
      visibleBoxAnimation ??
      Tween<double>(begin: 0, end: width).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            slideInterval.begin,
            slideInterval.end,
            curve: visibleBoxCurve,
          ),
        ),
      );

  /// White box covering (disappearing effect)
  Animation<double> get invisibleAnimation =>
      invisibleBoxAnimation ??
      Tween<double>(begin: 0, end: width).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(slideInterval.end, 1, curve: invisibleBoxCurve),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // Black sliding box
      Container(height: height, width: visibleAnimation.value, color: boxColor),
      // White covering box
      Container(
        height: height,
        width: invisibleAnimation.value,
        color: coverColor,
      ),
    ].addStack().addSizedBox(width: width, height: height);
  }
}
