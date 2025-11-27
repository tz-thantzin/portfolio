import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:portfolio/views/widgets/text/label_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/skill.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/app_text.dart';

class LanguageAndTools extends StatefulWidget {
  const LanguageAndTools({super.key});

  @override
  State<LanguageAndTools> createState() => _LanguageAndToolsState();
}

class _LanguageAndToolsState extends State<LanguageAndTools>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

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
    if (info.visibleFraction > 0.45 && mounted) {
      Future.delayed(duration500, () {
        _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Skill> skills = languagesAndTools(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(42),
        vertical: context.autoAdaptive(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LabelText(
            context.localization.programming_languages_tools.toUpperCase(),
            fontSize: FontSize.small,
          ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),

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
      ),
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
