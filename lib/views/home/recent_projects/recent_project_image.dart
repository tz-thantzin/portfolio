import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        minScale: widget.project.language == Language.iOS ? 0.6 : 0.7,
        maxScale: 0.9,
        child: AspectRatio(
          aspectRatio: 1,
          child: SvgPicture.asset(
            widget.project.imagePath!,
            width: context.autoAdaptive(s50),
            height: context.autoAdaptive(s50),
          ).addOpacity(opacity: context.isMobile ? 0.5 : 1.0),
        ),
      ),
    );
  }
}
