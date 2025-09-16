import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/skills_data.dart';
import '../../models/skill.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/content_text.dart';
import '../widgets/text/title_text.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      padding: EdgeInsets.symmetric(vertical: s40.h, horizontal: s24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LanguageAndTools(),
          SizedBox().verticalSpaceEnormous,
          WorkFlows(),
        ],
      ),
    );
  }
}

class LanguageAndTools extends StatelessWidget {
  const LanguageAndTools({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Skill> skills = languagesAndTools(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TitleText(context.localization.programming_languages_tools),
          SizedBox().verticalSpaceMassive,
          Wrap(
            spacing: s8.w,
            runSpacing: s16.h,
            alignment: WrapAlignment.center,
            children: skills.map((Skill skill) {
              return _SkillItem(iconPath: skill.iconPath, name: skill.name);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillItem extends StatelessWidget {
  final String iconPath;
  final String name;

  const _SkillItem({required this.iconPath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: name,
      child: Container(
        width: 70.r,
        height: 70.r,
        padding: EdgeInsets.all(s16.r),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(s8.r),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: kGrey100, blurRadius: 6, offset: Offset(2, 2)),
          ],
        ),
        child: Image.asset(iconPath, fit: BoxFit.contain),
      ),
    );
  }
}

class WorkFlows extends StatelessWidget {
  const WorkFlows({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Workflow> items = workflows(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TitleText(context.localization.workflows_title),
        SizedBox().verticalSpaceMassive,
        Column(
          children: items
              .map((Workflow workflow) => _WorkflowItem(workflow))
              .toList(),
        ),
      ],
    );
  }
}

class _WorkflowItem extends StatelessWidget {
  final Workflow workflow;
  const _WorkflowItem(this.workflow);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s40.w, vertical: s8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.check_circle_outline, color: Colors.green),
          SizedBox().horizontalSpaceSmall,
          Expanded(child: ContentText(workflow.description)),
        ],
      ),
    );
  }
}
