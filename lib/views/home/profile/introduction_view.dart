import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../../utils/extensions/extensions.dart';
import '../../widgets/animated_text_button.dart';
import 'intro_widget.dart';
import 'profile_image.dart';
import 'social_banner.dart';

class IntroductionView extends StatefulWidget {
  final VoidCallback onTapScrollDown;
  final AnimationController animationController;
  const IntroductionView({
    super.key,
    required this.animationController,
    required this.onTapScrollDown,
  });

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = !context.isMobile;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(isDesktop ? 0.3 : 0, -0.2),
                radius: 1.5,
                colors: [kGrey100.withValues(alpha: 0.5), kWhite],
              ),
            ),
          ),
        ),

        // Main Content
        Container(
          constraints: BoxConstraints(minHeight: context.screenHeight),
          padding: context.defaultPagePadding(),
          alignment: Alignment.center,
          child: context.isMobile ? _mobileView() : _desktopView(),
        ),

        // Social Banner (Fixed left on desktop)
        if (isDesktop)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: const Center(child: SocialBanner()),
          ),

        // "See My Work" Indicator
        Positioned(
          right: context.autoAdaptive(s16),
          bottom: context.autoAdaptive(s32),
          child: _buildScrollIndicator(),
        ),
      ],
    );
  }

  Widget _mobileView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const ProfileImage(),
        verticalSpaceMedium,
        IntroWidget(
          onTapScrollDown: widget.onTapScrollDown,
          controller: widget.animationController,
        ),
      ],
    );
  }

  Widget _desktopView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text Section
        Expanded(
          flex: 5,
          child:
              IntroWidget(
                onTapScrollDown: widget.onTapScrollDown,
                controller: widget.animationController,
              ).addPadding(
                padding: EdgeInsets.only(left: context.autoAdaptive(s48)),
              ),
        ),

        // Image Section
        Expanded(flex: 4, child: const Center(child: ProfileImage())),
      ],
    );
  }

  Widget _buildScrollIndicator() {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: AnimatedTextButton(
              context.localization.see_my_work.toUpperCase(),
              hoverColor: kTomato,
              textColor: kGrey800,
              onPressed: widget.onTapScrollDown,
              showLeading: false,
              style: context.labelSmall.copyWith(letterSpacing: 2),
            ),
          ),
          verticalSpaceSmall,
          Container(
            width: 1,
            height: context.autoAdaptive(40),
            color: kGrey800,
          ),
        ],
      ),
    );
  }
}
