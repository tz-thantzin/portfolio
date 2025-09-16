import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:provider/provider.dart';

import '../../data/contact_data.dart';
import '../../models/contact.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../view_models/home_view_model.dart';

class SocialBanner extends StatefulWidget {
  const SocialBanner({super.key});

  @override
  State<SocialBanner> createState() => _SocialBannerState();
}

class _SocialBannerState extends State<SocialBanner>
    with TickerProviderStateMixin {
  late final List<AnimationController> _bgControllers;
  late final List<Animation<double>> _bgScaleAnimations;

  IconData? _getIcon(String name) {
    switch (name.toLowerCase()) {
      case 'email':
        return Icons.email;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'facebook':
        return FontAwesomeIcons.facebook;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'github':
        return FontAwesomeIcons.github;
      default:
        return Icons.link;
    }
  }

  @override
  void initState() {
    super.initState();
    final contactList = contacts();

    // Create animation controllers for each icon's background
    _bgControllers = List<AnimationController>.generate(
      contactList.length,
      (int index) => AnimationController(vsync: this, duration: duration500),
    );

    // Scale animations from 0 to 1.2
    _bgScaleAnimations = _bgControllers
        .map(
          (AnimationController controller) =>
              Tween<double>(begin: 0, end: 1.2).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInOut),
              ),
        )
        .toList();

    // Start the sequential background animation
    _runSequentialBackgroundAnimation();
  }

  Future<void> _runSequentialBackgroundAnimation() async {
    for (final AnimationController controller in _bgControllers) {
      await controller.forward();
      await Future<void>.delayed(duration200);
      await controller.reverse();
    }

    // Repeat indefinitely
    _runSequentialBackgroundAnimation();
  }

  @override
  void dispose() {
    for (final AnimationController controller in _bgControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Contact> contactList = contacts();

    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: s8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s2.w, vertical: s8.h),
        decoration: BoxDecoration(
          color: kGrey100,
          borderRadius: BorderRadius.circular(s24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(contactList.length, (int i) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == contactList.length - 1 ? 0 : s8.h,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => context.read<HomeViewModel>().onContactMePressed(
                  contactList[i].link,
                ),
                child: SizedBox(
                  width: s40.r,
                  height: s40.r * 1.1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      // Animated background circle
                      AnimatedBuilder(
                        animation: _bgScaleAnimations[i],
                        builder: (_, child) => Transform.scale(
                          scale: _bgScaleAnimations[i].value,
                          child: Container(
                            width: s40.r,
                            height: s40.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kBlue.withValues(alpha: 0.2),
                            ),
                          ),
                        ),
                      ),
                      // Icon
                      Icon(
                        _getIcon(contactList[i].name),
                        color: kGrey700,
                        size: s24.r,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
