import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/work_experience_data.dart';
import '../../models/work_experience.dart';
import '../../presentations/configs/constants.dart';
import '../../presentations/configs/sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../../utils/style_theme.dart';
import '../widgets/text/title_text.dart';
import 'timeline_indicator.dart';
import 'title_period_view.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<WorkExperience> items = experiences(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s24.w, vertical: s40.h),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: s32.h,
        children: <Widget>[
          TitleText(context.localization.work_experience),
          verticalSpaceLarge,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: s40.w),
            child: context.isMobile
                ? Column(children: _buildTimelineItems(items))
                : Wrap(
                    alignment: WrapAlignment.start,
                    children: _buildTimelineItems(items),
                  ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTimelineItems(List<WorkExperience> items) {
    return List<Widget>.generate(items.length, (int index) {
      final WorkExperience exp = items[index];
      final bool hasNext = index < items.length - 1;
      final bool continueLine =
          hasNext &&
          items[index + 1].company == exp.company &&
          exp.company.isNotEmpty;

      return _TimelineItem(experience: exp, drawLineBelow: continueLine);
    });
  }
}

class _TimelineItem extends StatelessWidget {
  final WorkExperience experience;
  final bool drawLineBelow;

  const _TimelineItem({required this.experience, required this.drawLineBelow});

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = AppTextStyle.blockTitleStyle(context);

    return IntrinsicHeight(
      key: ValueKey<String>(
        '${Constants.experience}_${Localizations.localeOf(context).languageCode}',
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, titleStyle.fontSize! * 0.35),
            child: TimeLineIndicator(drawLineBelow: drawLineBelow),
          ),
          horizontalSpaceMedium,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: drawLineBelow ? 0 : s24.h),
              child: _CompanyTitleAndPeriod(experience: experience),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyTitleAndPeriod extends StatelessWidget {
  const _CompanyTitleAndPeriod({required this.experience});

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
              titleStyle: AppTextStyle.blockTitleStyle(context),
              periodStyle: AppTextStyle.blockPeriodStyle(context),
            ),
            if (experience.company.isNotEmpty)
              Text(
                experience.company,
                style: AppTextStyle.blockSubTitleStyle(context),
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
