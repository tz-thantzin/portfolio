import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_colors.dart';
import '../../data/contact_data.dart';
import '../../l10n/app_localizations.dart';
import '../../models/contact.dart';
import '../../style_theme.dart';
import '../../view_models/home_view_model.dart';
import 'text/caption_text.dart';

class SocialBanner extends StatefulWidget {
  const SocialBanner({super.key});

  @override
  State<SocialBanner> createState() => _SocialBannerState();
}

class _SocialBannerState extends State<SocialBanner>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _offsetAnimations;
  late final List<Animation<double>> _opacityAnimations;

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
    final List<Contact> contactList = contacts();

    _controllers = List<AnimationController>.generate(
      contactList.length,
      (int index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      ),
    );

    _offsetAnimations = _controllers
        .map(
          (AnimationController c) => Tween<Offset>(
            begin: const Offset(0, 1), // start slightly below
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();

    _opacityAnimations = _controllers
        .map(
          (AnimationController animationController) =>
              Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeIn,
                ),
              ),
        )
        .toList();

    // Staggered start
    _runStaggeredAnimations();
  }

  Future<void> _runStaggeredAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (final AnimationController c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Contact> contactList = contacts();

    return Container(
      width: 30.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: Sizes.sizeS.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 3,
            child: CaptionText(AppLocalizations.of(context)!.follow_me),
          ),
          SizedBox(height: Sizes.sizeM.h),
          Container(
            width: 0.5.w,
            height: 100.h,
            color: AppColors.grey300,
          ), // Straight Line
          SizedBox(height: Sizes.sizeM.h),
          for (int i = 0; i < contactList.length; i++)
            SlideTransition(
              position: _offsetAnimations[i],
              child: FadeTransition(
                opacity: _opacityAnimations[i],
                child: Padding(
                  padding: EdgeInsets.only(bottom: Sizes.sizeS.h),
                  child: InkWell(
                    onTap: () => context
                        .read<HomeViewModel>()
                        .onContactMePressed(contactList[i].link),
                    child: Icon(
                      _getIcon(contactList[i].name),
                      color: Colors.grey,
                      size: Sizes.sizeL.r,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
