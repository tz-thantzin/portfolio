import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/work_experience.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../../views/work_experience/work_info_detail.dart';
import '../widgets/animated_slide_widget.dart';

class WorkInfoView extends StatefulWidget {
  const WorkInfoView({super.key});

  @override
  State<WorkInfoView> createState() => _WorkInfoViewState();
}

class _WorkInfoViewState extends State<WorkInfoView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(vsync: this, duration: duration3000);
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.15 &&
        mounted &&
        !_slideController.isCompleted) {
      Future.delayed(duration300, _slideController.forward);
    }
  }

  List<Widget> _buildItems() {
    final workExperiences = experiences();

    /// grouping experiences by company
    final List<List<WorkExperience>> groupedExperiences = [];
    if (workExperiences.isNotEmpty) {
      List<WorkExperience> currentGroup = [workExperiences.first];
      for (int i = 1; i < workExperiences.length; i++) {
        if (workExperiences[i].company == workExperiences[i - 1].company &&
            workExperiences[i].company.isNotEmpty) {
          currentGroup.add(workExperiences[i]);
        } else {
          groupedExperiences.add(currentGroup);
          currentGroup = [workExperiences[i]];
        }
      }
      groupedExperiences.add(currentGroup);
    }

    int overallIndex = 0;

    return groupedExperiences.map((group) {
      final start = (overallIndex / workExperiences.length).clamp(0.0, 1.0);
      overallIndex += group.length;
      final end = (overallIndex / workExperiences.length).clamp(0.0, 1.0);

      return AnimatedSlideWidget(
        controller: _slideController,
        start: start,
        end: end,
        direction: SlideDirection.downToUp,
        child: _ExperienceGroup(group: group),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const ValueKey('work-info-view'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        constraints: BoxConstraints(minHeight: context.screenHeight),
        padding: EdgeInsets.symmetric(
          horizontal: context.autoAdaptive(s42),
          vertical: context.autoAdaptive(s16),
        ),
        child: Column(children: _buildItems()),
      ),
    );
  }
}

class _ExperienceGroup extends StatelessWidget {
  final List<WorkExperience> group;

  const _ExperienceGroup({required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.autoAdaptive(s10)),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(context.autoAdaptive(s12)),
        boxShadow: [
          BoxShadow(
            color: kGrey1000.withValues(alpha: 0.05),
            blurRadius: context.autoAdaptive(s4),
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: kGrey1000.withValues(alpha: 0.1), width: 1),
      ),
      child: Column(
        children: group.asMap().entries.map((entry) {
          final index = entry.key;
          final experience = entry.value;

          final isLastItem = index == group.length - 1;

          return Column(
            children: [
              _CardItem(experience: experience).addPadding(
                padding: EdgeInsets.only(
                  top: context.autoAdaptive(s20),
                  left: context.autoAdaptive(s20),
                  right: context.autoAdaptive(s20),
                ),
              ),
              if (!isLastItem)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: kGrey1000.withValues(alpha: 0.1),
                  indent: context.autoAdaptive(s20),
                  endIndent: context.autoAdaptive(s20),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final WorkExperience experience;

  const _CardItem({required this.experience});

  @override
  Widget build(BuildContext context) {
    return WorkInfoDetail(experience: experience);
  }
}
