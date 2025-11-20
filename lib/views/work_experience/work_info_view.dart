// lib/views/work_experience/work_info_view.dart
import 'package:flutter/material.dart';
import 'package:portfolio/models/work_experience.dart';
import 'package:portfolio/presentations/configs/constant_data.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/views/widgets/animated_slide_widget.dart';
import 'package:portfolio/views/work_experience/timeline_indicator.dart';
import 'package:portfolio/views/work_experience/work_info_detail.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_sizes.dart';

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
    final itemCount = workExperiences.length;

    return workExperiences.asMap().entries.map((entry) {
      final index = entry.key;
      final exp = entry.value;
      final hasNext = index < itemCount - 1;
      final continueLine =
          hasNext &&
          workExperiences[index + 1].company == exp.company &&
          exp.company.isNotEmpty;

      final start = (index / itemCount).clamp(0.0, 1.0);
      final end = ((index + 1) / itemCount).clamp(0.0, 1.0);

      return AnimatedSlideWidget(
        controller: _slideController,
        start: start,
        end: end,
        direction: SlideDirection.downToUp,
        child: _TimelineItem(experience: exp, drawLineBelow: continueLine),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final children = _buildItems();

    final content = context.isMobile
        ? Column(children: children)
        : Wrap(alignment: WrapAlignment.start, children: children);

    return VisibilityDetector(
      key: const ValueKey('work-info-view'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        constraints: BoxConstraints(minHeight: context.screenHeight),
        padding: EdgeInsets.symmetric(
          horizontal: context.autoAdaptive(42),
          vertical: context.autoAdaptive(16),
        ),
        child: content,
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final WorkExperience experience;
  final bool drawLineBelow;

  const _TimelineItem({required this.experience, required this.drawLineBelow});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!context.isMobile) ...[
            TimeLineIndicator(drawLineBelow: drawLineBelow),
            horizontalSpaceMedium,
          ],
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: drawLineBelow ? 0 : context.autoAdaptive(s14),
              ),
              child: WorkInfoDetail(experience: experience),
            ),
          ),
        ],
      ),
    );
  }
}
