import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/work_experience/timeline_indicator.dart';
import 'package:portfolio/views/work_experience/work_info_detail.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/work_experience.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../widgets/animated_slide_widget.dart';

class WorkInfoView extends StatefulWidget {
  const WorkInfoView({super.key});

  @override
  State<WorkInfoView> createState() => _WorkInfoViewState();
}

class _WorkInfoViewState extends State<WorkInfoView>
    with TickerProviderStateMixin {
  late final AnimationController _itemSlideAnimationController;

  @override
  void initState() {
    super.initState();
    _itemSlideAnimationController = AnimationController(
      vsync: this,
      duration: duration3000,
    );
  }

  @override
  void dispose() {
    _itemSlideAnimationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.15) {
      Future.delayed(duration300, () {
        if (mounted) _itemSlideAnimationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.screenHeight),
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(42),
        vertical: context.autoAdaptive(16),
      ),
      child: context.isMobile
          ? Column(children: _buildTimelineItems())
          : Wrap(
              alignment: WrapAlignment.start,
              children: _buildTimelineItems(),
            ),
    ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged);
  }

  List<Widget> _buildTimelineItems() {
    final List<WorkExperience> items = experiences();
    final int count = items.length;

    return items.asMap().entries.map((entry) {
      final int index = entry.key;
      final WorkExperience exp = entry.value;

      final bool hasNext = index < count - 1;
      final bool continueLine =
          hasNext &&
          items[index + 1].company == exp.company &&
          exp.company.isNotEmpty;

      final double start = (index * (1.0 / count)).clamp(0.0, 1.0);
      final double end = ((index + 1) * (1.0 / count)).clamp(0.0, 1.0);

      return AnimatedSlideWidget(
        controller: _itemSlideAnimationController,
        start: start,
        end: end,
        direction: SlideDirection.downToUp,
        child: _TimelineItem(experience: exp, drawLineBelow: continueLine),
      );
    }).toList();
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (!context.isMobile) ...[
            Transform.translate(
              offset: Offset(
                0,
                context.autoAdaptive(context.titleLarge.fontSize! * 0.05),
              ),
              child: TimeLineIndicator(drawLineBelow: drawLineBelow),
            ),
            horizontalSpaceMedium,
          ],

          Padding(
            padding: EdgeInsets.only(
              bottom: drawLineBelow ? 0 : context.autoAdaptive(s14),
            ),
            child: WorkInfoDetail(experience: experience),
          ).addExpanded(),
        ],
      ),
    );
  }
}
