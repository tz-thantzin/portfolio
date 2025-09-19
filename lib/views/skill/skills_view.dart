import 'package:flutter/material.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/presentations/configs/constant_data.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';
import 'package:portfolio/views/widgets/text/title_text.dart';

import '../../presentations/configs/constant_sizes.dart';

class SkillsView extends StatelessWidget {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s100),
        vertical: context.autoAdaptive(s65),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const LanguageAndTools(),
          SizedBox().verticalSpaceEnormous,
          const WorkFlows(),
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
      padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TitleText(context.localization.programming_languages_tools),
          SizedBox().verticalSpaceMassive,
          Wrap(
            spacing: context.autoAdaptive(8),
            runSpacing: context.autoAdaptive(16),
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
        width: context.autoAdaptive(s55),
        height: context.autoAdaptive(s55),
        padding: EdgeInsets.all(context.autoAdaptive(s16)),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(context.autoAdaptive(s8)),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: kGrey500, blurRadius: 3, offset: Offset(2, 2)),
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
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(40),
        vertical: context.autoAdaptive(8),
      ),
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
