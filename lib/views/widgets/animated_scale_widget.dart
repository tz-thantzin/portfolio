import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';

import '../../presentations/configs/duration.dart';

class AnimatedScaleWidget extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final Duration duration;
  const AnimatedScaleWidget({
    super.key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 1.8,
    this.duration = duration300,
  });

  @override
  State<AnimatedScaleWidget> createState() => _AnimatedScaleWidgetState();
}

class _AnimatedScaleWidgetState extends State<AnimatedScaleWidget> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      key: UniqueKey(),
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        color: kTransparent,
        clipBehavior: Clip.none,
        child: AnimatedScale(
          scale: _isHovered ? widget.maxScale : widget.minScale,
          duration: widget.duration,
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
