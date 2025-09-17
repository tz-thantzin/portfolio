import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_images.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/caption_text.dart';
import '../widgets/text/title_text.dart';
import 'widgets/circling_text.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop ? _DesktopView() : _MobileView();
  }
}

class _DesktopView extends StatelessWidget {
  const _DesktopView();

  @override
  Widget build(BuildContext context) {
    final double size = s450.h;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: <Widget>[
          // Base image
          SizedBox(
            height: size,
            child: AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(kTypingIcon, fit: BoxFit.contain),
            ),
          ),

          Positioned(
            top: s60.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: s8.w, vertical: s8.h),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(s16.r),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kBlack.withValues(alpha: 0.05),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleText(
                    context.localization.year_of_work_experience,
                    fontSize: s26,
                  ),
                  SizedBox().horizontalSpaceTiny,
                  CaptionText(context.localization.years_success),
                ],
              ),
            ),
          ),

          // Circling text positioned directly inside Stack
          Positioned(
            top: s280.h,
            left: s62.w,
            child: CirclingText(
              context.localization.creative_mobile_app_developer,
              radius: s40,
              textStyle: context.circlingTextStyle.copyWith(color: kWhite),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    final double size = 250.h;
    return SizedBox(
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: SvgPicture.asset(kTypingIcon, fit: BoxFit.contain),
      ),
    );
  }
}
