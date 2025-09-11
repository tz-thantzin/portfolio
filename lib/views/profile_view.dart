import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../app_colors.dart';
import '../l10n/app_localizations.dart';
import '../style_theme.dart';
import '../utils/constants.dart';
import '../view_models/home_view_model.dart';
import 'widgets/animated_slide_widget.dart';
import 'widgets/snail_light_button.dart';

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
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

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
    final bool isMobile =
        MediaQuery.of(context).size.width < Constants.desktopSize;

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
            padding: EdgeInsets.symmetric(
              vertical: Paddings.paddingXXL.h,
              horizontal: Paddings.paddingL.w,
            ),
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                isMobile
                    ? AnimatedSlideWidget(
                        animation: _greetingOffsetAnimation,
                        fadeAnimation: _fadeAnimation,
                        child: _GreetingWidget(isMobile: isMobile),
                      )
                    : Expanded(
                        flex: 2,
                        child: AnimatedSlideWidget(
                          animation: _greetingOffsetAnimation,
                          fadeAnimation: _fadeAnimation,
                          child: _GreetingWidget(isMobile: isMobile),
                        ),
                      ),
                isMobile
                    ? AnimatedSlideWidget(
                        animation: _profileOffsetAnimation,
                        fadeAnimation: _fadeAnimation,
                        child: _ProfileImage(isMobile),
                      )
                    : Expanded(
                        flex: 1,
                        child: AnimatedSlideWidget(
                          animation: _profileOffsetAnimation,
                          fadeAnimation: _fadeAnimation,
                          child: _ProfileImage(isMobile),
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
  final bool isMobile;
  const _GreetingWidget({required this.isMobile});

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
      padding: EdgeInsets.symmetric(horizontal: Sizes.sizeL.w),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectableText(
            AppLocalizations.of(context)!.hi,
            textHeightBehavior: textHeightBehavior,
            style: AppTextStyle.subHeaderTextStyle(context),
          ),
          SizedBox(height: Sizes.sizeS.h),
          SelectableText.rich(
            TextSpan(
              children: localeCode == LanguageCode.ja.name
                  ? <InlineSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.thantzin,
                        style: AppTextStyle.headerTextStyle(context),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.i_am,
                        style: AppTextStyle.subHeaderTextStyle(context),
                      ),
                    ]
                  : <InlineSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.i_am,
                        style: AppTextStyle.subHeaderTextStyle(context),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.thantzin,
                        style: AppTextStyle.headerTextStyle(context),
                      ),
                    ],
            ),
            textHeightBehavior: textHeightBehavior,
          ),
          SizedBox(height: Sizes.sizeS.h),
          SelectableText(
            AppLocalizations.of(context)!.senior_mobile_developer,
            textHeightBehavior: textHeightBehavior,
            style: AppTextStyle.descriptionTextStyle(context),
          ),
          SizedBox(height: Sizes.sizeXL.h),
          SnailLightButton(
            label: AppLocalizations.of(context)!.download_resume,
            icon: Icon(Icons.download_rounded, color: AppColors.white),
            onPressed: context.read<HomeViewModel>().onDownloadResumeBtnPressed,
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final bool isMobile;
  const _ProfileImage(this.isMobile);

  @override
  Widget build(BuildContext context) {
    final double? size = isMobile ? 250.r : 450.r;

    return SizedBox(
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(ImagePath.codingImagePath, fit: BoxFit.contain),
      ),
    );
  }
}
