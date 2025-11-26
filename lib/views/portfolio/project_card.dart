import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';

import '../../core/di/providers.dart';
import '../../models/project.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../views/portfolio/project_image.dart';

class ProjectCard extends ConsumerWidget {
  final Project project;

  const ProjectCard(this.project, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = context.isDesktop;
    final bool hasGithub = project.github != null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(24),
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
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          splashColor: kIndigo.withValues(alpha: 0.1),
          highlightColor: kIndigo.withValues(alpha: 0.05),
          onTap: hasGithub
              ? () => ref
                    .read(homeViewModelProvider)
                    .onProjectView(project.github!)
              : null,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: isDesktop
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: ProjectImage(project)),
                      const SizedBox(width: 32),
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
                      const SizedBox(height: 24),
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
        Text(
          project.projectName,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: bold,
            color: kBlack,
            height: 1.2,
          ),
        ),
        verticalSpaceTiny,
        Text(
          project.description,
          style: context.textTheme.bodySmall?.copyWith(
            color: kGrey700,
            height: 1.6,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
