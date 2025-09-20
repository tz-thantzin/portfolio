import 'package:flutter/material.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../../presentations/configs/constant_sizes.dart';

class ProjectImage extends StatefulWidget {
  final Project project;
  const ProjectImage(this.project, {super.key});

  @override
  State<ProjectImage> createState() => _ProjectImageState();
}

class _ProjectImageState extends State<ProjectImage> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(s24)),
      alignment: Alignment.centerRight,
      child: MouseRegion(
        key: ValueKey('MouseRegion_Portfolio_Project'),
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: _isHovered ? 2 : 1.5,
          duration: duration300,
          curve: Curves.easeOut,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              widget.project.imagePath!,
              fit: BoxFit.contain,
            ).addOpacity(opacity: 0.5),
          ),
        ),
      ),
    );
  }
}
