import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/work_experience/title_period_view.dart';

import '../../models/work_experience.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';

class CompanyTitleAndPeriod extends StatelessWidget {
  const CompanyTitleAndPeriod({required this.experience});

  final WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    );

    return Wrap(
      spacing: s40.h,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitlePeriodView(
              title: experience.title,
              period: experience.period,
              titleStyle: context.blockTitleStyle.copyWith(color: kGrey100),
              periodStyle: context.blockPeriodStyle,
            ),
            if (experience.company.isNotEmpty)
              Text(
                experience.company,
                style: context.blockSubTitleStyle,
                textHeightBehavior: textHeightBehavior,
                overflow: TextOverflow.ellipsis,
              ),
            SizedBox().verticalSpaceMassive,
          ],
        ),
      ],
    );
  }
}
