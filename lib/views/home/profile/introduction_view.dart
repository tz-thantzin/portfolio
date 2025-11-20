import 'package:flutter/material.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/widget_ex.dart';
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

class _IntroductionViewState extends State<IntroductionView>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _fadeIntro;
  late final Animation<double> _fadeProfile;

  @override
  void initState() {
    super.initState();

    _fadeIntro = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _fadeProfile = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  Widget _buildIntro() {
    return FadeTransition(
      opacity: _fadeIntro,
      child: IntroWidget(onTapScrollDown: widget.onTapScrollDown),
    );
  }

  Widget _buildProfileImage() {
    return FadeTransition(opacity: _fadeProfile, child: const ProfileImage());
  }

  Widget _mobileView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [_buildProfileImage(), verticalSpaceMedium, _buildIntro()],
    );
  }

  Widget _desktopView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_buildIntro(), Spacer(), _buildProfileImage()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: context.screenHeight),
          alignment: Alignment.center,
          child: [
            if (!context.isMobile)
              Container(
                height: context.screenHeight,
                alignment: Alignment.centerLeft,
                child: const SocialBanner(),
              ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.autoAdaptive(42),
                vertical: context.autoAdaptive(16),
              ),
              height: context.screenHeight,
              alignment: Alignment.center,
              child: context.isMobile ? _mobileView() : _desktopView(),
            ),
          ].addStack(alignment: Alignment.center),
        ),
        Positioned(
          right: context.autoAdaptive(s16),
          bottom: context.autoAdaptive(s16),
          child: RotatedBox(
            quarterTurns: 1,
            child: AnimatedTextButton(
              context.localization.see_my_work.toUpperCase(),
              hoverColor: kGrey700,
              textColor: kBlack,
              onPressed: () {
                widget.onTapScrollDown();
              },
            ),
          ),
        ),
      ],
    );
  }
}
