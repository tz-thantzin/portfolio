import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../widgets/animated_slide_widget.dart';
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
  late AnimationController _controller;
  late Animation<Offset> _greetingOffsetAnimation;
  late Animation<Offset> _profileOffsetAnimation;
  late Animation<double> _fadeAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: duration1000, vsync: this);

    _greetingOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _profileOffsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    VisibilityDetectorController.instance.forget(const Key('profile_section'));
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return VisibilityDetector(
          key: const Key('profile_section'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.2 && !_hasAnimated && mounted) {
              _controller.forward();
              _hasAnimated = true;
            }
          },
          child: Container(
            constraints: BoxConstraints(minHeight: context.screenHeight),
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                if (!context.isMobile)
                  Container(
                    height: context.screenHeight,
                    alignment: Alignment.centerLeft,
                    child: const SocialBanner(),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.autoAdaptive(s100),
                    vertical: context.autoAdaptive(s65),
                  ),
                  height: context.screenHeight,
                  alignment: Alignment.center,
                  child: Flex(
                    direction: context.isMobile
                        ? Axis.vertical
                        : Axis.horizontal,
                    mainAxisAlignment: context.isMobile
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      context.isMobile
                          ? AnimatedSlideWidget(
                              animation: _greetingOffsetAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: const IntroWidget(),
                            )
                          : Expanded(
                              flex: 2,
                              child: AnimatedSlideWidget(
                                animation: _greetingOffsetAnimation,
                                fadeAnimation: _fadeAnimation,
                                child: const IntroWidget(),
                              ),
                            ),
                      SizedBox().verticalSpaceLarge,
                      context.isMobile
                          ? AnimatedSlideWidget(
                              animation: _profileOffsetAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: const ProfileImage(),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                left: context.autoAdaptive(24),
                              ),
                              child: AnimatedSlideWidget(
                                animation: _profileOffsetAnimation,
                                fadeAnimation: _fadeAnimation,
                                child: const ProfileImage(),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
