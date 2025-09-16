import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/views/work_experience/work_info.dart';

import '../../data/work_experience_data.dart';
import '../../models/work_experience.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/title_text.dart';
import 'timeline_indicator.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<WorkExperience> items = experiences(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      padding: EdgeInsets.symmetric(horizontal: s24.w, vertical: s40.h),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: s32.h,
        children: <Widget>[
          TitleText(context.localization.work_experience),
          SizedBox().verticalSpaceLarge,
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
    return IntrinsicHeight(
      key: ValueKey<String>('$experience'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, context.blockTitleStyle.fontSize! * 0.35),
            child: TimeLineIndicator(drawLineBelow: drawLineBelow),
          ),
          SizedBox().horizontalSpaceMedium,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: drawLineBelow ? 0 : s24.h),
              child: CompanyTitleAndPeriod(experience: experience),
            ),
          ),
        ],
      ),
    );
  }
}
