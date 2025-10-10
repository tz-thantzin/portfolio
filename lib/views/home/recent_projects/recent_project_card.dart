import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/presentations/configs/constant_data.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/views/home/recent_projects/recent_project_image.dart';
import 'package:provider/provider.dart';

import '../../../models/project.dart';
import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../view_models/home_view_model.dart';
import '../../widgets/animated_text_button.dart';
import '../../widgets/text/content_text.dart';

class RecentProjectCard extends StatefulWidget {
  final Project project;

  const RecentProjectCard(this.project, {super.key});

  @override
  State<RecentProjectCard> createState() => _RecentProjectCardState();
}

class _RecentProjectCardState extends State<RecentProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: context.autoAdaptive(s16)),
      child: context.isMobile
          ? _MobileView(widget.project)
          : _WebView(widget.project),
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
        color: kPortfolioBg,
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

class _ProjectDetail extends StatelessWidget {
  final Project project;
  const _ProjectDetail(this.project);

  @override
  Widget build(BuildContext context) {
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
                context.read<HomeViewModel>().onProjectView(project.github!),
          ),
        ],
        if (project.pubDev != null) ...[
          AnimatedTextButton(
            'Pub Dev',
            textColor: kIndigo,
            hoverColor: kGrey500,
            onPressed: () =>
                context.read<HomeViewModel>().onProjectView(project.pubDev!),
          ),
        ],
      ],
    );
  }
}
