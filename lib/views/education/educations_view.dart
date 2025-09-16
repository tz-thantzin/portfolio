import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

import '../../data/education_data.dart';
import '../../models/education.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/title_text.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Education> items = educations(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      padding: EdgeInsets.symmetric(horizontal: s24.w, vertical: s40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TitleText(context.localization.education),
          SizedBox().verticalSpaceMassive,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: s40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((Education edu) => _EducationItem(edu: edu))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationItem extends StatelessWidget {
  const _EducationItem({required this.edu});

  final Education edu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: s24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _TitlePeriodResponsive(
            title: edu.degree,
            period: edu.duration,
            titleStyle: context.blockTitleStyle,
            periodStyle: context.blockPeriodStyle,
          ),
          SizedBox().verticalSpaceSmall,
          Text(
            edu.institution,
            style: context.blockSubTitleStyle,
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
  });

  final String title;
  final String period;
  final TextStyle titleStyle;
  final TextStyle periodStyle;

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

    if (context.isMobile) {
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
