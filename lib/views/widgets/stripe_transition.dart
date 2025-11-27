import 'dart:ui';

import 'package:flutter/material.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';

class StripeTransition extends StatelessWidget {
  const StripeTransition({
    super.key,
    required this.controller,
    required this.sectorCount,
    this.color = kBlack100,
    this.blurSigma = 12.0,
  });

  final AnimationController controller;
  final int sectorCount;
  final Color color;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth / sectorCount;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Subtle blurred background while animating
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(color: Colors.transparent),
        ),

        Row(
          children: List.generate(sectorCount, (i) {
            final delay = i / sectorCount;
            final anim = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(
                  delay * 0.6,
                  (delay * 0.6) + 0.4,
                  curve: Curves.easeOutCubic,
                ),
              ),
            );

            return AnimatedBuilder(
              animation: anim,
              builder: (_, _) {
                return Transform.translate(
                  offset: Offset(width * (1.0 - anim.value), 0),
                  child: Container(
                    width: width,
                    color: color,
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: s8,
                      decoration: BoxDecoration(
                        color: kWhite.withValues(alpha: 0.15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            spreadRadius: 2,
                            color: Colors.white.withValues(
                              alpha: 0.3 * anim.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
