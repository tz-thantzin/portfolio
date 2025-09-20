import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import 'intro_widget.dart';
import 'profile_image.dart';
import 'social_banner.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIntro;
  late final Animation<double> _fadeProfile;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);

    _fadeIntro = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _fadeProfile = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleVisibility(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_hasAnimated && mounted) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  Widget _buildIntro(BuildContext context) {
    final intro = FadeTransition(
      opacity: _fadeIntro,
      child: const IntroWidget(),
    );

    return context.isMobile ? intro : Expanded(flex: 2, child: intro);
  }

  Widget _buildProfileImage(BuildContext context) {
    final profile = FadeTransition(
      opacity: _fadeProfile,
      child: const ProfileImage(),
    );

    return context.isMobile
        ? profile
        : Padding(
            padding: EdgeInsets.only(left: context.autoAdaptive(24)),
            child: profile,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            horizontal: context.autoAdaptive(s60),
            vertical: context.autoAdaptive(s65),
          ),
          height: context.screenHeight,
          alignment: Alignment.center,
          child: Flex(
            direction: context.isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: context.isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIntro(context),
              verticalSpaceLarge,
              _buildProfileImage(context),
            ],
          ),
        ),
      ].addStack(),
    ).addVisibilityDetector(onDetectVisibility: _handleVisibility);
  }
}
