import 'package:flutter/material.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/views/portfolio/project_card.dart';

class ProjectImage extends StatefulWidget {
  final Project project;
  final Direction direction;
  const ProjectImage(
    this.project, {
    this.direction = Direction.right,
    super.key,
  });

  @override
  State<ProjectImage> createState() => _ProjectImageState();
}

class _ProjectImageState extends State<ProjectImage> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: widget.direction == Direction.left
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedScale(
            scale: _isHovered ? 1.5 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: context.screenHeight * 0.8,
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  widget.project.imagePath!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
