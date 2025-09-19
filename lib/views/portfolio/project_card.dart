import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/view_models/home_view_model.dart';
import 'package:portfolio/views/portfolio/project_image.dart';
import 'package:portfolio/views/widgets/animated_text_button.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';
import 'package:provider/provider.dart';

import '../../models/project.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../widgets/text/title_text.dart';

enum Direction { left, right }

class ProjectCard extends StatefulWidget {
  final Project project;
  final Gradient? gradient;
  final Direction direction;

  const ProjectCard(
    this.project, {
    this.gradient,
    this.direction = Direction.right,
    super.key,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      if (widget.project.imagePath != null &&
          widget.direction == Direction.left)
        ProjectImage(widget.project, direction: widget.direction),

      Flexible(flex: 2, child: _buildTextColumn(context)),

      if (widget.project.imagePath != null &&
          widget.direction == Direction.right)
        ProjectImage(widget.project, direction: widget.direction),
    ];

    return SizedBox(
      height: context.autoAdaptive(s280),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(context.autoAdaptive(s24)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: context.autoAdaptive(s24),
              vertical: context.autoAdaptive(s32),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleText(
          widget.project.projectName,
          textColor: kIndigo,
          fontSize: s24,
        ),
        SizedBox().verticalSpaceTiny,
        ContentText(
          widget.project.description,
          textColor: kWhite,
          fontSize: s12,
        ),
        if (widget.project.github != null) ...[
          SizedBox().verticalSpaceSmall,
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
