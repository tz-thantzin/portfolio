import 'package:flutter/material.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/presentations/configs/constant_data.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';
import 'package:portfolio/views/widgets/text/title_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../widgets/animated_fade_widget.dart';
import '../widgets/animated_slide_widget.dart';

class SkillsView extends StatefulWidget {
  const SkillsView({super.key});

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_hasAnimated && mounted) {
      Future.delayed(duration500, () {
        if (mounted) _controller.forward();
      });
      _hasAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s60),
        vertical: context.autoAdaptive(s65),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.0,
            end: 0.4,
            child: const LanguageAndTools(),
          ),
          verticalSpaceEnormous,
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.3,
            end: 0.7,
            child: _WorkFlows(controller: _controller),
          ),
        ],
      ),
    ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged);
  }
}

class LanguageAndTools extends StatelessWidget {
  const LanguageAndTools({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Skill> skills = languagesAndTools(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TitleText(context.localization.programming_languages_tools),
        verticalSpaceMassive,
        Wrap(
          spacing: context.autoAdaptive(8),
          runSpacing: context.autoAdaptive(16),
          alignment: WrapAlignment.center,
          children: skills.map((Skill skill) {
            return _SkillItem(iconPath: skill.iconPath, name: skill.name);
          }).toList(),
        ),
      ],
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
        width: context.autoAdaptive(s50),
        height: context.autoAdaptive(s50),
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

class _WorkFlows extends StatelessWidget {
  final AnimationController controller;
  const _WorkFlows({required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<Workflow> items = workflows(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TitleText(context.localization.workflows_title),
        verticalSpaceMassive,
        Column(
          children: items.asMap().entries.map((entry) {
            final int index = entry.key;
            final Workflow workflow = entry.value;

            final double slideStart = 0.7 + index * 0.05;
            final double slideEnd = (slideStart + 0.2).clamp(0.0, 1.0);

            return AnimatedSlideWidget(
              controller: controller,
              start: slideStart,
              end: slideEnd,
              direction: SlideDirection.up,
              duration: duration3000,
              child: _WorkflowItem(workflow),
            );
          }).toList(),
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
          horizontalSpaceSmall,
          Expanded(child: ContentText(workflow.description)),
        ],
      ),
    );
  }
}
