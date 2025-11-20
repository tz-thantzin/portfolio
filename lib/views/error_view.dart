import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/routing/routes.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/views/widgets/animated_slide_button.dart';

import '../presentations/configs/constant_images.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(32),
            vertical: context.autoAdaptive(48),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Big 404 background text
        Text(
          "404",
          style: context.displayLarge.copyWith(
            fontSize: context.autoAdaptive(140),
            fontWeight: FontWeight.w900,
            color: kWhite.withValues(alpha: 0.15),
            letterSpacing: 8,
            height: 0.9,
          ),
        ),

        verticalSpaceMedium,

        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            kPageNotFound,
            height: context.autoAdaptive(260),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),

        verticalSpaceLarge,

        // Title
        Text(
          context.localization.page_not_found,
          style: context.headlineLarge.copyWith(
            fontSize: context.autoAdaptive(32),
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
          textAlign: TextAlign.center,
        ),

        verticalSpaceMedium,

        // Subtitle
        Text(
          context.localization.sorry_page_not_exist,
          style: context.bodyLarge.copyWith(
            fontSize: context.autoAdaptive(18),
            color: kWhite70,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),

        verticalSpaceMassive,

        // Button
        AnimatedSlideButton(
          height: context.autoAdaptive(56),
          title: context.localization.go_home.toUpperCase(),
          hasIcon: false,
          onPressed: () => GoRouter.of(context).goNamed(RouteName.home),
        ),

        verticalSpaceLarge,
      ],
    );
  }

  // Desktop & Tablet Layout
  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Huge 404 background
                  Text(
                    "404",
                    style: context.displayLarge.copyWith(
                      fontSize: context.autoAdaptive(180),
                      fontWeight: FontWeight.w900,
                      color: kWhite.withValues(alpha: 0.12),
                      letterSpacing: 16,
                      height: 0.9,
                    ),
                  ),

                  verticalSpaceMedium,

                  Text(
                    context.localization.page_not_found,
                    style: context.headlineLarge.copyWith(
                      fontSize: context.autoAdaptive(48),
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),

                  verticalSpaceMedium,

                  Text(
                    context.localization.sorry_page_not_exist,
                    style: context.bodyLarge.copyWith(
                      fontSize: context.autoAdaptive(20),
                      color: kWhite70,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),

            // Spacing between columns
            horizontalSpaceMassive,

            // Right: Image
            SizedBox(
              width: context.autoAdaptive(380),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(kPageNotFound, fit: BoxFit.contain),
              ),
            ),
          ],
        ),

        verticalSpaceMassive,

        // Centered button below everything
        Center(
          child: AnimatedSlideButton(
            height: context.autoAdaptive(36),
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
