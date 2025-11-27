import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/routing/routes.dart';
import '../../../models/project.dart';
import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_data.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/duration.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';
import '../../../utils/extensions/widget_ex.dart';
import '../../widgets/animated_fade_widget.dart';
import '../../widgets/animated_slide_widget.dart';
import '../../widgets/animated_text_button.dart';
import '../../widgets/text/app_text.dart';
import '../../widgets/text/body_text.dart';
import '../../widgets/text/title_text.dart';
import 'recent_project_card.dart';

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

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s42),
        vertical: context.autoAdaptive(s50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedFadeWidget(
                controller: _controller,
                start: 0.0,
                end: 0.5,
                child: TitleText(
                  context.localization.crafted_with_love,
                  textAlign: TextAlign.left,
                  color: kIndigo,
                  fontWeight: superBold,
                  style: GoogleFonts.caveat(),
                ),
              )
              .addAlign(alignment: Alignment.centerLeft)
              .addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),

          verticalSpaceSmall,

          AnimatedFadeWidget(
            controller: _controller,
            start: 0.5,
            end: 0.8,
            child: BodyText(
              context.localization.recent_projects,
              fontSize: FontSize.small,
              textAlign: TextAlign.left,
              color: kGrey1000,
            ),
          ).addAlign(alignment: Alignment.centerLeft),

          verticalSpaceMassive,

          // show projects
          ...projects.asMap().entries.map((entry) {
            final int index = entry.key;
            final Project project = entry.value;

            final int count = projects.length;
            final double step = 1.0 / count;

            final double slideStart = (index * step).clamp(0.0, 1.0);
            final double slideEnd = ((index + 1) * step).clamp(0.0, 1.0);

            return AnimatedSlideWidget(
              controller: _recentProjectController,
              start: slideStart.clamp(0.0, 1.0),
              end: slideEnd.clamp(0.0, 1.0),
              direction: SlideDirection.upToDown,
              child: RecentProjectCard(project, isOddIndex: index.isOdd),
            );
          }),
          verticalSpaceMassive,

          AnimatedTextButton(
            context.localization.view_all_projects.toUpperCase(),
            hoverColor: kGrey700,
            textColor: kBlack,
            fontSize: s14,
            onPressed: () {
              GoRouter.of(context).goNamed(RouteName.portfolio);
            },
          ),
        ],
      ),
    );
  }
}
