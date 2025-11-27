import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/views/widgets/text/app_text.dart';
import 'package:portfolio/views/widgets/text/body_text.dart';
import 'package:portfolio/views/widgets/text/custom_text.dart';
import 'package:portfolio/views/widgets/text/headline_text.dart';
import 'package:portfolio/views/widgets/text/title_text.dart';

import '../../core/routing/routes.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../views/widgets/animated_slide_button.dart';
import '../presentations/configs/constant_images.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: context.screenHeight),
            padding: EdgeInsets.symmetric(
              horizontal: context.autoAdaptive(s42),
              vertical: context.autoAdaptive(s16),
            ),
            alignment: Alignment.center,
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }

  // ====================== Mobile Layout ======================
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Subtle 404 watermark
        HeadlineText(
          "404",
          fontSize: FontSize.large,
          fontWeight: superBold,
          color: kGrey900.withValues(alpha: s03),
          letterSpacing: 8,
          height: 0.9,
        ),

        verticalSpaceMedium,

        ClipRRect(
          borderRadius: BorderRadius.circular(s24),
          child: Image.asset(
            kNotFound,
            height: context.autoAdaptive(s260),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),

        verticalSpaceLarge,

        // Title
        TitleText(
          context.localization.page_not_found,
          fontSize: FontSize.small,
          fontWeight: bold,
          color: kGrey1200,
          textAlign: TextAlign.center,
        ),

        verticalSpaceMedium,

        // Subtitle
        BodyText(
          context.localization.sorry_page_not_exist,
          color: kGrey800,
          height: 1.6,
          textAlign: TextAlign.center,
        ),

        verticalSpaceMassive,

        AnimatedSlideButton(
          height: context.autoAdaptive(s55),
          title: context.localization.go_home.toUpperCase(),
          hasIcon: false,
          onPressed: () => GoRouter.of(context).goNamed(RouteName.home),
        ),

        verticalSpaceLarge,
      ],
    );
  }

  // ====================== Desktop & Tablet Layout ======================
  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side – Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Huge subtle 404
                  CustomText(
                    "404",
                    style: context.displayLarge.copyWith(
                      fontSize: context.autoAdaptive(s180),
                      fontWeight: superBold,
                      color: kGrey900.withValues(alpha: s03),
                      letterSpacing: 16,
                      height: 0.9,
                    ),
                  ),

                  verticalSpaceMedium,

                  TitleText(
                    context.localization.page_not_found,
                    fontSize: FontSize.large,
                    fontWeight: bold,
                    color: kGrey1200,
                    textAlign: TextAlign.center,
                  ),

                  verticalSpaceMedium,

                  BodyText(
                    context.localization.sorry_page_not_exist,
                    fontSize: FontSize.large,
                    color: kGrey800,
                    height: 1.7,
                  ),
                ],
              ),
            ),

            horizontalSpaceMassive,

            // Right side – Image
            SizedBox(
              width: context.autoAdaptive(s380),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(s32),
                child: Image.asset(kNotFound, fit: BoxFit.contain),
              ),
            ),
          ],
        ),

        verticalSpaceMassive,

        // Centered Go Home button
        Center(
          child: AnimatedSlideButton(
            height: context.autoAdaptive(s36),
            title: context.localization.go_home.toUpperCase(),
            hasIcon: false,
            onPressed: () => GoRouter.of(context).goNamed(RouteName.home),
          ),
        ),

        verticalSpaceLarge,
      ],
    );
  }
}
