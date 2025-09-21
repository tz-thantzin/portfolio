import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/view_models/home_view_model.dart';
import 'package:portfolio/views/portfolio/project_image.dart';
import 'package:portfolio/views/widgets/animated_text_button.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final Gradient? gradient;
  final Color textColor;

  const ProjectCard(
    this.project, {
    this.gradient,
    this.textColor = kIndigo,
    super.key,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(context.autoAdaptive(s24)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s24),
        vertical: context.autoAdaptive(s32),
      ),
      child: Stack(
        children: [ProjectImage(widget.project), _buildTextColumn(context)],
      ),
    );
  }

  Widget _buildTextColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.project.projectName,
          style: context.titleSmall.copyWith(
            color: widget.textColor,
            fontSize: context.autoAdaptive(s20),
            fontWeight: superBold,
          ),
        ),
        verticalSpaceTiny,
        ContentText(
          widget.project.description,
          textColor: kWhite,
          fontSize: s14,
        ),
        if (widget.project.github != null) ...[
          verticalSpaceSmall,
          AnimatedTextButton(
            context.localization.view_project,
            onPressed: () => context.read<HomeViewModel>().onProjectView(
              widget.project.github!,
            ),
          ),
        ],
        if (widget.project.pubDev != null) ...[
          AnimatedTextButton(
            'Pub Dev',
            onPressed: () => context.read<HomeViewModel>().onProjectView(
              widget.project.pubDev!,
            ),
          ),
        ],
      ],
    );
  }
}
