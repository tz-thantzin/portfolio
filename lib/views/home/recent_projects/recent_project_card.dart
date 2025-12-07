import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/views/widgets/text/title_text.dart';

import '../../../core/configs/configs.dart';
import '../../../core/di/providers.dart';
import '../../../models/project.dart';
import '../../../utils/extensions/extensions.dart';
import '../../widgets/animated_text_button.dart';
import '../../widgets/text/app_text.dart';
import '../../widgets/text/body_text.dart';
import 'recent_project_image.dart';

class RecentProjectCard extends ConsumerWidget {
  final Project project;
  final bool isOddIndex;

  const RecentProjectCard(this.project, {super.key, required this.isOddIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.autoAdaptive(s64)),
      child: context.isMobile
          ? _MobileView(project)
          : _DesktopView(project, isOddIndex: isOddIndex),
    );
  }
}

/// Mobile view
class _MobileView extends StatelessWidget {
  final Project project;
  const _MobileView(this.project);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProjectImage(project, isOddIndex: true),
        verticalSpaceMedium,
        _ProjectDetail(project),
      ],
    );
  }
}

class _DesktopView extends StatelessWidget {
  final Project project;
  final bool isOddIndex;
  const _DesktopView(this.project, {required this.isOddIndex});

  @override
  Widget build(BuildContext context) {
    final children = isOddIndex
        ? <Widget>[
            Expanded(flex: 2, child: _ProjectDetail(project)),
            horizontalSpaceMassive,
            Expanded(
              flex: 3,
              child: _ProjectImage(project, isOddIndex: isOddIndex),
            ),
          ]
        : <Widget>[
            Expanded(
              flex: 3,
              child: _ProjectImage(project, isOddIndex: isOddIndex),
            ),
            horizontalSpaceMassive,
            Expanded(flex: 2, child: _ProjectDetail(project)),
          ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _ProjectImage extends StatelessWidget {
  final Project project;
  final bool isOddIndex;
  const _ProjectImage(this.project, {required this.isOddIndex});

  @override
  Widget build(BuildContext context) {
    int index = recentProjects().indexOf(project) + 1;
    String formattedIndex = index.toString().padLeft(2, '0');

    /// MOBILE VIEW
    if (context.isMobile) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPortfolioBg.withValues(alpha: s005),
          borderRadius: BorderRadius.circular(context.autoAdaptive(s24)),
          border: Border.all(color: kPrimary.withValues(alpha: s03)),
        ),
        padding: EdgeInsets.all(context.autoAdaptive(s16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // PROJECT IMAGE
            RecentProjectImage(project, isOddIndex: isOddIndex),
            verticalSpaceSmall,

            // PROJECT NAME
            BodyText(
              project.projectName,
              fontSize: FontSize.large,
              textAlign: TextAlign.center,
              color: kPortfolioTitle,
              fontWeight: semiBold,
            ),
          ],
        ),
      );
    }
    /// DESKTOP VIEW
    else {
      final Widget indexText = TitleText(
        formattedIndex,
        fontSize: FontSize.large,
        color: kPrimary.withValues(alpha: s03),
        fontWeight: superBold,
        style: GoogleFonts.poppins(),
      );

      final children = isOddIndex
          ? [
              RecentProjectImage(project, isOddIndex: isOddIndex),
              horizontalSpaceMedium,
              indexText,
            ]
          : [
              indexText,
              horizontalSpaceMedium,
              RecentProjectImage(project, isOddIndex: isOddIndex),
            ];

      return Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: kBlack.withValues(alpha: s005),
          borderRadius: BorderRadius.circular(context.autoAdaptive(s24)),

          border: Border.all(color: kGrey200.withValues(alpha: s05)),
          boxShadow: [
            BoxShadow(
              color: kBlack.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.all(context.autoAdaptive(s32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: children,
        ),
      );
    }
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
        if (!context.isMobile) ...[
          BodyText(
            project.projectName,
            fontSize: FontSize.large,
            fontWeight: superBold,
            color: kPortfolioTitle,
          ),
          verticalSpaceTiny,
        ],

        BodyText(
          project.description,
          fontSize: FontSize.small,
          color: kGrey1000.withValues(alpha: s08),
        ),
        if (project.link != null) ...[
          verticalSpaceMedium,
          AnimatedTextButton(
            context.localization.view_project,
            textColor: kPrimary,
            hoverColor: kPrimary.withValues(alpha: s05),
            fontSize: context.isMobile ? s14 : s12,
            onPressed: () =>
                ref.read(homeViewModelProvider).onProjectView(project.link!),
            style: context.labelSmall,
          ),
        ],
      ],
    );
  }
}
