import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../view_models/home_view_model.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import 'widgets/shadow_button.dart';
import 'widgets/typewrite_text.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            style: context.subHeaderTextStyle.copyWith(color: kGrey1000),
          ),
          SizedBox().verticalSpaceSmall,
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SelectableText(
                context.localization.i_am,
                style: context.subHeaderTextStyle.copyWith(color: kGrey1000),
              ),
              TypewriterText(
                context.localization.thantzin,
                style: context.headerTextStyle.copyWith(color: kIndigo),
              ),
            ],
          ),
          SizedBox().verticalSpaceSmall,
          SelectableText(
            context.localization.senior_mobile_developer,
            textHeightBehavior: textHeightBehavior,
            style: context.descriptionTextStyle.copyWith(color: kGrey900),
          ),
          SizedBox().verticalSpaceMassive,
          ShadowButton(
            label: context.localization.download_resume,
            icon: const Icon(Icons.download_rounded, color: kWhite),
            onPressed: () async {
              context.read<HomeViewModel>().onDownloadResumeBtnPressed();
            },
          ),
        ],
      ),
    );
  }
}
