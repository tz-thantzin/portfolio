import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/configs/configs.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/utils.dart';
import '../../widgets/text/app_text.dart';
import '../../widgets/text/body_text.dart';
import '../../widgets/text/title_text.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    // Continuous floating animation (breathing effect)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = context.autoAdaptive(context.isMobile ? s300 : s450);

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // 1. Background Blob/Circle
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kGrey100,
                  boxShadow: [
                    BoxShadow(
                      color: kBlack.withValues(alpha: 0.05),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            ),

            // 2. Image
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGrey200.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: kGrey200.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.autoAdaptive(s18),
                vertical: context.autoAdaptive(s8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(kTZ, fit: BoxFit.cover),
            ),

            // 3. Floating Experience Card
            Positioned(
              bottom: context.isMobile ? 0 : context.autoAdaptive(s40),
              right: -20,
              child: _ExperienceCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String experienceDuration = calculateWorkExperience(
      DateTime(2014, 2),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: context.isMobile
              ? EdgeInsets.symmetric(
                  horizontal: context.autoAdaptive(s28),
                  vertical: context.autoAdaptive(s12),
                )
              : context.defaultPagePadding(),
          decoration: BoxDecoration(
            color: kWhite.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            border: Border.all(color: kWhite, width: 2),
            boxShadow: [
              BoxShadow(
                color: kBlack.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(context.autoAdaptive(s8)),
                decoration: BoxDecoration(
                  color: kTomato.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  color: kTomato,
                  size: context.autoAdaptive(s20),
                ),
              ),
              horizontalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    experienceDuration,
                    fontSize: FontSize.medium,
                    color: kBlack,
                    fontWeight: bold,
                    style: GoogleFonts.outfit(height: 1),
                  ),
                  BodyText(
                    context.localization.years_success,
                    fontSize: FontSize.small,
                    color: kGrey700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
