import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/project.dart';
import '../../utils/extensions/layout_adapter_ex.dart';

class ProjectImage extends StatelessWidget {
  final Project project;
  const ProjectImage(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;
    final double aspectRatio = isMobile ? 6.9 : 1.0;
    final double size = context.autoAdaptive(50.0);

    return SizedBox(
      height: size,
      width: isMobile ? size * aspectRatio : size,
      child: SvgPicture.asset(
        project.imagePath!,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
