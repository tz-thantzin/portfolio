import 'package:flutter/material.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_scale_widget.dart';

import '../../presentations/configs/constant_sizes.dart';

class ProjectImage extends StatefulWidget {
  final Project project;
  const ProjectImage(this.project, {super.key});

  @override
  State<ProjectImage> createState() => _ProjectImageState();
}

class _ProjectImageState extends State<ProjectImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(s24)),
      alignment: Alignment.centerRight,
      child: AnimatedScaleWidget(
        minScale: 1.5,
        maxScale: 2.0,
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.asset(
            widget.project.imagePath!,
            fit: BoxFit.contain,
          ).addOpacity(opacity: 0.6),
        ),
      ),
    );
  }
}
