import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/app_colors.dart';
import '../../presentations/configs/constants.dart';
import '../../presentations/configs/duration.dart';
import '../../presentations/configs/sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../../utils/style_theme.dart';
import '../../view_models/home_view_model.dart';
import '../home/widgets/snail_light_button.dart';
import '../widgets/animated_slide_widget.dart';

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

    // Animation for the greeting message (left to right)
    _greetingOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animation for the profile image (right to left)
    _profileOffsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Shared fade animation for both widgets
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return VisibilityDetector(
          key: Key('profile_section'),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction > 0.2 && !_hasAnimated && mounted) {
              _controller.forward();
              _hasAnimated = true;
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s24.w, vertical: s40.h),
            child: Flex(
              direction: context.isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: context.isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                context.isMobile
                    ? AnimatedSlideWidget(
                        animation: _greetingOffsetAnimation,
                        fadeAnimation: _fadeAnimation,
                        child: _GreetingWidget(),
                      )
                    : Expanded(
                        flex: 2,
                        child: AnimatedSlideWidget(
                          animation: _greetingOffsetAnimation,
                          fadeAnimation: _fadeAnimation,
                          child: _GreetingWidget(),
                        ),
                      ),
                context.isMobile
                    ? AnimatedSlideWidget(
                        animation: _profileOffsetAnimation,
                        fadeAnimation: _fadeAnimation,
                        child: _ProfileImage(),
                      )
                    : Expanded(
                        flex: 1,
                        child: AnimatedSlideWidget(
                          animation: _profileOffsetAnimation,
                          fadeAnimation: _fadeAnimation,
                          child: _ProfileImage(),
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

class _GreetingWidget extends StatelessWidget {
  const _GreetingWidget();

  @override
  Widget build(BuildContext context) {
    final String? localeCode = context
        .read<HomeViewModel>()
        .locale
        ?.languageCode;

    final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s24.w),
      child: Column(
        crossAxisAlignment: context.isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectableText(
            context.localization.hi,
            textHeightBehavior: textHeightBehavior,
            style: AppTextStyle.subHeaderTextStyle(context),
          ),
          SizedBox().verticalSpaceSmall,
          SelectableText.rich(
            TextSpan(
              children: localeCode == LanguageCode.ja.name
                  ? <InlineSpan>[
                      TextSpan(
                        text: context.localization.thantzin,
                        style: AppTextStyle.headerTextStyle(context),
                      ),
                      TextSpan(
                        text: context.localization.i_am,
                        style: AppTextStyle.subHeaderTextStyle(context),
                      ),
                    ]
                  : <InlineSpan>[
                      TextSpan(
                        text: context.localization.i_am,
                        style: AppTextStyle.subHeaderTextStyle(context),
                      ),
                      TextSpan(
                        text: context.localization.thantzin,
                        style: AppTextStyle.headerTextStyle(context),
                      ),
                    ],
            ),
            textHeightBehavior: textHeightBehavior,
          ),
          SizedBox(height: s8.h),
          SelectableText(
            context.localization.senior_mobile_developer,
            textHeightBehavior: textHeightBehavior,
            style: AppTextStyle.descriptionTextStyle(context),
          ),
          SizedBox(height: s32.h),
          SnailLightButton(
            label: context.localization.download_resume,
            icon: Icon(Icons.download_rounded, color: kWhite),
            onPressed: context.read<HomeViewModel>().onDownloadResumeBtnPressed,
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    final double? size = context.isMobile ? 250.h : 450.h;

    return SizedBox(
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(ImagePath.codingImagePath, fit: BoxFit.contain),
      ),
    );
  }
}
