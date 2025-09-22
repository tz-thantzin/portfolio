import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
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

class _SkillsViewState extends State<SkillsView> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _workFlowSlideAnimationController;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
    _workFlowSlideAnimationController = AnimationController(
      vsync: this,
      duration: duration3000,
    );
    _listenAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    _workFlowSlideAnimationController.dispose();
    super.dispose();
  }

  Future<void> _listenAnimations() async {
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Future.delayed(duration500, () {
          if (mounted) _workFlowSlideAnimationController.forward();
        });
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.45 && !_hasAnimated && mounted) {
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
            start: 0.5,
            end: 0.8,
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
            return _SkillItem(skill: skill);
          }).toList(),
        ),
      ],
    );
  }
}

class _SkillItem extends StatelessWidget {
  final Skill skill;

  const _SkillItem({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: skill.name,
      child: SizedBox(
        width: context.autoAdaptive(s48),
        height: context.autoAdaptive(s48),
        child: Stack(
          alignment: Alignment.center,
          children: [
            LiquidLinearProgressIndicator(
              value: skill.percentage / 100,
              valueColor: AlwaysStoppedAnimation(
                kSkillWavy.withValues(alpha: 0.2),
              ),
              backgroundColor: kGrey200,
              borderRadius: context.autoAdaptive(s10),
              direction: Axis.vertical,
            ),
            SvgPicture.asset(
              skill.iconPath,
              fit: BoxFit.contain,
              width: context.autoAdaptive(s26),
              height: context.autoAdaptive(s26),
            ),
          ],
        ),
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

            final int count = items.length;
            final double step = 1.0 / count;

            // Each item gets its own slice in the timeline
            final double slideStart = (index * step).clamp(0.0, 1.0);
            final double slideEnd = ((index + 1) * step).clamp(0.0, 1.0);

            return AnimatedSlideWidget(
              controller: controller,
              start: slideStart,
              end: slideEnd,
              direction: SlideDirection.down,
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
