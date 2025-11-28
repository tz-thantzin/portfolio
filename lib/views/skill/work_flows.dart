import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/configs/configs.dart';
import '../../models/skill.dart';
import '../../utils/extensions/extensions.dart';
import '../widgets/animated_slide_widget.dart';
import '../widgets/text/app_text.dart';
import '../widgets/text/body_text.dart';
import '../widgets/text/label_text.dart';

class WorkFlows extends StatefulWidget {
  const WorkFlows({super.key});

  @override
  State<WorkFlows> createState() => _WorkFlowsState();
}

class _WorkFlowsState extends State<WorkFlows>
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
    final List<Workflow> items = workflows(context);

    return Padding(
      padding: context.defaultPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LabelText(
            context.localization.workflows_title.toUpperCase(),
            fontSize: FontSize.small,
          ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),
          verticalSpaceMassive,
          Column(
            children: items.asMap().entries.map((entry) {
              final int index = entry.key;
              final Workflow workflow = entry.value;

              final int count = items.length;
              final double step = 1.0 / count;

              final double slideStart = (index * step).clamp(0.0, 1.0);
              final double slideEnd = ((index + 1) * step).clamp(0.0, 1.0);

              return AnimatedSlideWidget(
                controller: _controller,
                start: slideStart,
                end: slideEnd,
                direction: SlideDirection.upToDown,
                child: _WorkflowItem(workflow),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _WorkflowItem extends StatelessWidget {
  final Workflow workflow;
  const _WorkflowItem(this.workflow);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.autoAdaptive(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.check_circle_outline, color: kPrimary),
          horizontalSpaceSmall,
          Expanded(
            child: BodyText(workflow.description, fontSize: FontSize.small),
          ),
        ],
      ),
    );
  }
}
