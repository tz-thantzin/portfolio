import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/configs/configs.dart';
import '../../core/di/providers.dart';
import '../../models/project.dart';
import '../../utils/extensions/extensions.dart';
import '../../views/portfolio/project_image.dart';
import '../widgets/text/app_text.dart';
import '../widgets/text/body_text.dart';

class ProjectCard extends ConsumerWidget {
  final Project project;

  const ProjectCard(this.project, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = context.isDesktop;
    final bool hasGithub = project.github != null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: s8),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(s24),
        boxShadow: [
          BoxShadow(
            color: kBlack.withValues(alpha: 0.12),
            offset: const Offset(0, 16),
            blurRadius: 40,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: kBlack.withValues(alpha: 0.08),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(s24),
        child: InkWell(
          borderRadius: BorderRadius.circular(s24),
          splashColor: kIndigo.withValues(alpha: 0.1),
          highlightColor: kIndigo.withValues(alpha: 0.05),
          onTap: hasGithub
              ? () => ref
                    .read(homeViewModelProvider)
                    .onProjectView(project.github!)
              : null,
          child: Padding(
            padding: EdgeInsets.all(context.autoAdaptive(s28)),
            child: isDesktop
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: ProjectImage(project)),
                      horizontalSpaceMassive,
                      Expanded(
                        flex: 5,
                        child: _buildContent(context, ref, hasGithub),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProjectImage(project),
                      verticalSpaceLarge,
                      _buildContent(context, ref, hasGithub),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, bool hasGithub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BodyText(
          project.projectName,
          fontSize: FontSize.small,
          fontWeight: semiBold,
          color: kBlack,
          height: 1.2,
        ),
        verticalSpaceTiny,
        BodyText(
          project.description,
          fontSize: FontSize.small,
          color: kGrey700,
          height: 1.6,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
