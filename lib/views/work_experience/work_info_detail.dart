import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../../models/work_experience.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/constants.dart';

class WorkInfoDetail extends StatelessWidget {
  const WorkInfoDetail({required this.experience, super.key});

  final WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? s0 : context.autoAdaptive(s24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _JobTitlePeriodView(
            title: experience.title.toUpperCase(),
            period: experience.period,
            titleStyle: context.bodyMedium.copyWith(
              color: kBlack,
              fontWeight: bold,
            ),
            periodStyle: context.bodySmall.copyWith(color: kGrey1000),
          ),

          if (experience.company.isNotEmpty)
            Text(
              experience.company,
              style: context.bodySmall.copyWith(color: kGrey1000),
              textHeightBehavior: textHeightBehavior,
              overflow: TextOverflow.ellipsis,
            ),

          // Display Work Mode
          Padding(
            padding: EdgeInsets.only(top: context.autoAdaptive(s4)),
            child: Text(
              _workModeToLabel(experience.workMode),
              style: context.bodySmall.copyWith(
                color: kGrey500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          verticalSpaceMedium,

          // Display responsibilities if not empty
          if (experience.responsibilities != null &&
              experience.responsibilities!.isNotEmpty)
            _ResponsibilitiesList(items: experience.responsibilities!),

          verticalSpaceMassive,
        ],
      ),
    );
  }

  String _workModeToLabel(WorkMode mode) {
    switch (mode) {
      case WorkMode.remote:
        return 'Remote';
      case WorkMode.onsite:
        return 'Onsite';
      case WorkMode.hybrid:
        return 'Hybrid';
    }
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

class _ResponsibilitiesList extends StatelessWidget {
  const _ResponsibilitiesList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: context.autoAdaptive(s6)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ',
                style: context.bodySmall.copyWith(
                  color: kGrey1000,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: context.bodySmall.copyWith(color: kGrey1000),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
