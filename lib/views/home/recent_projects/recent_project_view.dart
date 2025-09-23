import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/home/recent_projects/recent_project_card.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../presentations/configs/constant_data.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/duration.dart';
import '../../../route/routes.dart';
import '../../widgets/animated_fade_widget.dart';
import '../../widgets/animated_slide_widget.dart';
import '../../widgets/animated_text_button.dart';

class RecentProjectView extends StatefulWidget {
  const RecentProjectView({super.key});

  @override
  State<RecentProjectView> createState() => _RecentProjectViewState();
}

class _RecentProjectViewState extends State<RecentProjectView>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _recentProjectController;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
    _recentProjectController = AnimationController(
      vsync: this,
      duration: duration3000,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _recentProjectController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.45 && mounted) {
      _startAnimations();
    }
  }

  void _startAnimations() {
    _controller.forward();
    _controller.addStatusListener((status) {
      Future.delayed(duration300, () {
        if (mounted) {
          _recentProjectController.forward();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final projects = recentProjects();
    final totalProjects = projects.length;
    final double slice = 0.2;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s60),
        vertical: context.autoAdaptive(s65),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedFadeWidget(
                controller: _controller,
                start: 0.0,
                end: 0.5,
                child: Text(
                  context.localization.crafted_with_love,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.indieFlower(
                    textStyle: context.bodyLarge.copyWith(
                      color: kIndigo,
                      fontSize: context.autoAdaptive(s24),
                      fontWeight: superBold,
                    ),
                  ),
                ),
              )
              .addAlign(alignment: Alignment.centerLeft)
              .addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),

          verticalSpaceSmall,

          AnimatedFadeWidget(
            controller: _controller,
            start: 0.5,
            end: 0.8,
            child: Text(
              context.localization.recent_projects,
              textAlign: TextAlign.left,
              style: context.bodySmall.copyWith(
                color: kGrey1000,
                fontSize: context.autoAdaptive(s14),
              ),
            ),
          ).addAlign(alignment: Alignment.centerLeft),

          verticalSpaceMassive,

          // show projects
          ...projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;

            final start = 0.1 + (index * slice / totalProjects);
            final end = start + slice / totalProjects;

            return AnimatedSlideWidget(
              controller: _recentProjectController,
              start: start.clamp(0.0, 1.0),
              end: end.clamp(0.0, 1.0),
              direction: SlideDirection.upToDown,
              child: RecentProjectCard(project),
            );
          }),
          verticalSpaceMassive,

          AnimatedTextButton(
            context.localization.view_all_projects.toUpperCase(),
            hoverColor: kGrey700,
            textColor: kBlack,
            fontSize: s16,
            onPressed: () {
              GoRouter.of(context).goNamed(RouteName.portfolio);
            },
          ),
        ],
      ),
    );
  }
}
