import 'package:flutter/material.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_scale_widget.dart';

import '../../../presentations/configs/constant_sizes.dart';

class RecentProjectImage extends StatefulWidget {
  final Project project;
  const RecentProjectImage(this.project, {super.key});

  @override
  State<RecentProjectImage> createState() => _RecentProjectImageState();
}

class _RecentProjectImageState extends State<RecentProjectImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.autoAdaptive(s100),
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
