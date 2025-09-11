import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/work_experience_data.dart';
import '../l10n/app_localizations.dart';
import '../models/work_experience.dart';
import '../style_theme.dart';
import '../utils/constants.dart';
import 'widgets/text/title_text.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < Constants.desktopSize;

    final List<WorkExperience> items = experiences(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Paddings.paddingXXL.h,
        horizontal: Paddings.paddingL.w,
      ),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: Sizes.sizeXL.h,
        children: <Widget>[
          TitleText(AppLocalizations.of(context)!.work_experience),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.sizeXXL.w),
            child: isMobile
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
            child: _TimeLineIndicator(drawLineBelow: drawLineBelow),
          ),
          SizedBox(width: Sizes.sizeM.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: drawLineBelow ? 0 : Sizes.sizeL.h,
              ),
              child: _CompanyTitleAndPeriod(experience: experience),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeLineIndicator extends StatelessWidget {
  const _TimeLineIndicator({required this.drawLineBelow});

  final bool drawLineBelow;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        if (drawLineBelow)
          Expanded(
            child: Container(
              width: 1.w,
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}

class _CompanyTitleAndPeriod extends StatelessWidget {
  const _CompanyTitleAndPeriod({required this.experience});

  final WorkExperience experience;

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < Constants.desktopSize;

    final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    );

    return Wrap(
      spacing: Sizes.sizeXXL.h,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TitlePeriodResponsive(
              title: experience.title,
              period: experience.period,
              titleStyle: AppTextStyle.blockTitleStyle(context),
              periodStyle: AppTextStyle.blockPeriodStyle(context),
              isMobile: isMobile,
            ),
            if (experience.company.isNotEmpty)
              Text(
                experience.company,
                style: AppTextStyle.blockSubTitleStyle(context),
                textHeightBehavior: textHeightBehavior,
                overflow: TextOverflow.ellipsis,
              ),
            SizedBox(height: Sizes.sizeXL.h),
          ],
        ),
      ],
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
    final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    );

    final Text titleText = Text(
      title,
      style: titleStyle,
      textHeightBehavior: textHeightBehavior,
      overflow: TextOverflow.ellipsis,
    );

    final Text periodText = Text(
      period,
      style: periodStyle,
      overflow: TextOverflow.ellipsis,
      textHeightBehavior: textHeightBehavior,
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
