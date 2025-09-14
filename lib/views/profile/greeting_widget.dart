import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../presentations/configs/app_colors.dart';
import '../../../presentations/configs/sizes.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/style_theme.dart';
import '../../../view_models/home_view_model.dart';
import '../../presentations/configs/constants.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../home/widgets/snail_light_button.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

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
            icon: const Icon(Icons.download_rounded, color: kWhite),
            onPressed: context.read<HomeViewModel>().onDownloadResumeBtnPressed,
          ),
        ],
      ),
    );
  }
}
