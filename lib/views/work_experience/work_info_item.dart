import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../../models/work_experience.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/constants.dart';

class WorkInfoDetail extends StatelessWidget {
  const WorkInfoDetail({required this.experience});

  final WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? s0 : context.autoAdaptive(s24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _JobTitlePeriodView(
            title: experience.title.toUpperCase(),
            period: experience.period,
            titleStyle: context.bodyMedium.copyWith(color: kGrey100),
            periodStyle: context.bodySmall.copyWith(color: kGrey500),
          ),
          if (experience.company.isNotEmpty)
            Text(
              experience.company,
              style: context.bodySmall.copyWith(color: kGrey500),
              textHeightBehavior: textHeightBehavior,
              overflow: TextOverflow.ellipsis,
            ),
          verticalSpaceMassive,
        ],
      ),
    );
  }
}

class _JobTitlePeriodView extends StatelessWidget {
  const _JobTitlePeriodView({
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
      textHeightBehavior: textHeightBehavior,
    );

    final Text periodText = Text(
      period,
      style: periodStyle,
      textHeightBehavior: textHeightBehavior,
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
      children: <Widget>[titleText.addExpanded(), periodText],
    );
  }
}
