import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/education_data.dart';
import '../l10n/app_localizations.dart';
import '../models/education.dart';
import '../style_theme.dart';
import '../utils/constants.dart';
import 'widgets/text/title_text.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < Constants.desktopSize;

    final List<Education> items = educations(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Paddings.paddingXXL.h,
        horizontal: Paddings.paddingL.w,
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TitleText(AppLocalizations.of(context)!.education),
          SizedBox(height: Sizes.sizeXL.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.sizeXXL.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map(
                    (Education edu) =>
                        _EducationItem(edu: edu, isMobile: isMobile),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationItem extends StatelessWidget {
  const _EducationItem({required this.edu, required this.isMobile});

  final Education edu;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizes.sizeL.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _TitlePeriodResponsive(
            title: edu.degree,
            period: edu.duration,
            titleStyle: AppTextStyle.blockTitleStyle(context),
            periodStyle: AppTextStyle.blockPeriodStyle(context),
            isMobile: isMobile,
          ),
          SizedBox(height: Sizes.sizeS.h),
          Text(
            edu.institution,
            style: AppTextStyle.blockSubTitleStyle(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _TitlePeriodResponsive extends StatelessWidget {
  const _TitlePeriodResponsive({
    required this.title,
    required this.period,
    required this.titleStyle,
    required this.periodStyle,
    required this.isMobile,
  });

  final String title;
  final String period;
  final TextStyle titleStyle;
  final TextStyle periodStyle;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final Text titleText = Text(
      title,
      style: titleStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
    final Text periodText = Text(
      period,
      style: periodStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[titleText, periodText],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(child: titleText),
        periodText,
      ],
    );
  }
}
