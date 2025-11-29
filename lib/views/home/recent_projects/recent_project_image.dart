import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/configs/configs.dart';
import '../../../models/project.dart';
import '../../../utils/extensions/extensions.dart';
import '../../widgets/animated_scale_widget.dart';

class RecentProjectImage extends StatefulWidget {
  final Project project;
  final bool isOddIndex;
  const RecentProjectImage(this.project, {super.key, required this.isOddIndex});

  @override
  State<RecentProjectImage> createState() => _RecentProjectImageState();
}

class _RecentProjectImageState extends State<RecentProjectImage> {
  @override
  Widget build(BuildContext context) {
    final alignment = context.isMobile
        ? Alignment.center
        : widget.isOddIndex
        ? Alignment.centerLeft
        : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: AnimatedScaleWidget(
        minScale: context.isMobile ? 0.6 : 0.8,
        maxScale: 1.0,
        child: Container(
          constraints: context.isMobile
              ? BoxConstraints(maxWidth: context.screenWidth * 0.3)
              : null,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kBlack.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            color: kWhite,
          ),
          padding: EdgeInsets.all(context.autoAdaptive(s12)),
          child: AspectRatio(
            aspectRatio: 1,
            child: SvgPicture.asset(
              widget.project.imagePath!,
              fit: BoxFit.contain,
              height: context.autoAdaptive(s55),
            ),
          ),
        ),
      ),
    );
  }
}
