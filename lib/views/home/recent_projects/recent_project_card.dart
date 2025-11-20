// lib/views/home/recent_projects/recent_project_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/di/providers.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/presentations/configs/constant_data.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/views/home/recent_projects/recent_project_image.dart';

import '../../widgets/animated_text_button.dart';
import '../../widgets/text/content_text.dart';

class RecentProjectCard extends ConsumerWidget {
  final Project project;

  const RecentProjectCard(this.project, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.autoAdaptive(s16)),
      child: context.isMobile ? _MobileView(project) : _WebView(project),
    );
  }
}

class _MobileView extends StatelessWidget {
  final Project project;
  const _MobileView(this.project);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProjectImage(project),
        verticalSpaceSmall,
        _ProjectDetail(project),
      ],
    );
  }
}

class _WebView extends StatelessWidget {
  final Project project;
  const _WebView(this.project);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _ProjectImage(project)),
          horizontalSpaceMedium,
          Expanded(flex: 1, child: _ProjectDetail(project)),
        ],
      ),
    );
  }
}

class _ProjectImage extends StatelessWidget {
  final Project project;
  const _ProjectImage(this.project);

  @override
  Widget build(BuildContext context) {
    int index = recentProjects().indexOf(project) + 1;
    String formattedIndex = index.toString().padLeft(2, '0');

    final children = index.isOdd
        ? [
            Text(
              formattedIndex,
              style: GoogleFonts.permanentMarker(
                textStyle: context.titleLarge.copyWith(
                  color: kPrimary,
                  fontSize: context.autoAdaptive(s60),
                ),
              ),
            ),
            RecentProjectImage(project),
          ]
        : [
            RecentProjectImage(project),
            Text(
              formattedIndex,
              style: GoogleFonts.permanentMarker(
                textStyle: context.titleLarge.copyWith(
                  color: kPrimary,
                  fontSize: context.autoAdaptive(s60),
                ),
              ),
            ),
          ];

    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: kPortfolioBg.withValues(alpha: 0.3),
        border: Border.all(color: kWhite70),
        borderRadius: BorderRadius.circular(context.autoAdaptive(s24)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s48),
        vertical: context.autoAdaptive(s24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    );
  }
}

class _ProjectDetail extends ConsumerWidget {
  final Project project;
  const _ProjectDetail(this.project);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          project.projectName,
          style: context.titleSmall.copyWith(
            color: kPortfolioTitle,
            fontSize: context.autoAdaptive(s22),
            fontWeight: superBold,
          ),
        ),
        verticalSpaceTiny,
        ContentText(project.description, textColor: kIndigo, fontSize: s14),
        if (project.github != null) ...[
          verticalSpaceSmall,
          AnimatedTextButton(
            context.localization.view_project,
            textColor: kIndigo,
            hoverColor: kGrey500,

            onPressed: () =>
                ref.read(homeViewModelProvider).onProjectView(project.github!),
          ),
        ],
      ],
    );
  }
}
