import 'package:flutter/material.dart';

import '../../presentations/configs/duration.dart';

class FadeScaleRouteTransition extends PageRouteBuilder {
  final Widget enterWidget;
  FadeScaleRouteTransition({required this.enterWidget, super.settings})
    : super(
        transitionDuration: duration800,
        reverseTransitionDuration: duration800,
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return enterWidget;
            },
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              // Fade + Scale effect
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
                child: ScaleTransition(
                  scale:
                      Tween<double>(
                        begin: 0.95, // slightly smaller at start
                        end: 1.0, // full size
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                  child: child,
                ),
              );
            },
      );
}
