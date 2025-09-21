import 'package:flutter/material.dart';

import '../../presentations/configs/duration.dart';

class AnimatedScaleWidget extends StatefulWidget {
  final Widget child;
  const AnimatedScaleWidget({super.key, required this.child});

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
      child: AnimatedScale(
        scale: _isHovered ? 1.5 : 1.0,
        duration: duration300,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
