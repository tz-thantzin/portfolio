import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../widgets/animated_slide_widget.dart';
import 'greeting_widget.dart';
import 'profile_image.dart';
import 'social_banner.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection>
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

    // Greeting message animation (left → right)
    _greetingOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Profile image animation (right → left)
    _profileOffsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Shared fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    VisibilityDetectorController.instance.forget(Key('profile_section'));
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return VisibilityDetector(
          key: const Key('profile_section'),
          onVisibilityChanged: (VisibilityInfo info) {
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
                Visibility(
                  visible: !context.isMobile,
                  child: Container(
                    margin: EdgeInsets.only(top: context.appBarHeight),
                    padding: EdgeInsets.symmetric(vertical: s40.h),
                    width: context.isDesktop ? 30.w : 45.w,
                    child: const SocialBanner(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: s24.w,
                    vertical: s40.h,
                  ),
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
                              child: const GreetingWidget(),
                            )
                          : Expanded(
                              flex: 2,
                              child: AnimatedSlideWidget(
                                animation: _greetingOffsetAnimation,
                                fadeAnimation: _fadeAnimation,
                                child: const GreetingWidget(),
                              ),
                            ),
                      context.isMobile
                          ? AnimatedSlideWidget(
                              animation: _profileOffsetAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: const ProfileImage(),
                            )
                          : Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(left: s24.w),
                                child: AnimatedSlideWidget(
                                  animation: _profileOffsetAnimation,
                                  fadeAnimation: _fadeAnimation,
                                  child: const ProfileImage(),
                                ),
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
