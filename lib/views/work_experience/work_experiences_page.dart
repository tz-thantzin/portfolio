import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_fade_widget.dart';
import 'package:portfolio/views/widgets/header_view.dart';
import 'package:portfolio/views/work_experience/work_info_item.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/work_experience.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../route/routes.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../footer/footer_view.dart';
import '../widgets/animated_slide_widget.dart';
import '../wrapper.dart';
import 'timeline_indicator.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _itemSlideAnimationController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
    _itemSlideAnimationController = AnimationController(
      vsync: this,
      duration: duration3000,
    );
    _listenAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    _itemSlideAnimationController.dispose();
    super.dispose();
  }

  Future<void> _listenAnimations() async {
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Future.delayed(duration500, () {
          if (mounted) _itemSlideAnimationController.forward();
        });
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.45 && mounted) {
      Future.delayed(duration300, () {
        if (mounted) _controller.forward();
      });
    }
  }

  void _onTapScrollDown() {
    _scrollController.animateTo(
      context.screenHeight,
      duration: duration500,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<WorkExperience> items = experiences(context);
    return Wrapper(
      selectedRoute: RoutePaths.experience,
      selectedPageName: RouteName.experience,
      child: Column(
        children: [
          HeaderView(
            title: context.localization.work_experience,
            onTapScrollDown: _onTapScrollDown,
          ),
          verticalSpaceMassive,
          Container(
            constraints: BoxConstraints(minHeight: context.screenHeight),
            padding: EdgeInsets.symmetric(
              horizontal: context.autoAdaptive(s60),
              vertical: context.autoAdaptive(s50),
            ),
            child: context.isMobile
                ? Column(children: _buildTimelineItems(items))
                : Wrap(
                    alignment: WrapAlignment.start,
                    children: _buildTimelineItems(items),
                  ),
          ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),
          FooterView(),
        ],
      ).addScrollView(controller: _scrollController),
    );
  }

  List<Widget> _buildTimelineItems(List<WorkExperience> items) {
    final int count = items.length;
    final double step = 1.0 / count;

    return List<Widget>.generate(count, (int index) {
      final WorkExperience exp = items[index];
      final bool hasNext = index < count - 1;
      final bool continueLine =
          hasNext &&
          items[index + 1].company == exp.company &&
          exp.company.isNotEmpty;

      final double start = (index * step).clamp(0.0, 1.0);
      final double end = ((index + 1) * step).clamp(0.0, 1.0);

      return AnimatedFadeWidget(
        controller: _controller,
        start: start,
        end: end,
        child: AnimatedSlideWidget(
          controller: _itemSlideAnimationController,
          start: start,
          end: end,
          duration: duration3000,
          direction: SlideDirection.downToUp,
          child: _TimelineItem(experience: exp, drawLineBelow: continueLine),
        ),
      );
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
