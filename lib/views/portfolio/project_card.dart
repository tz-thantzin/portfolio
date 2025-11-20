import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/providers.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../views/portfolio/project_image.dart';
import '../../views/widgets/animated_text_button.dart';
import '../../views/widgets/text/content_text.dart';

import '../../models/project.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';

class ProjectCard extends ConsumerWidget {
  final Project project;

  const ProjectCard(this.project, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: kPortfolioBg.withValues(alpha: 0.3),
        border: Border.all(color: kWhite70),
        borderRadius: BorderRadius.circular(context.autoAdaptive(s24)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s24),
        vertical: context.autoAdaptive(s32),
      ),
      child: Stack(
        children: [ProjectImage(project), _buildTextColumn(context, ref)],
      ),
    );
  }

  Widget _buildTextColumn(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
            onPressed: () =>
                ref.read(homeViewModelProvider).onProjectView(project.github!),
          ),
        ],
      ],
    );
  }
}
