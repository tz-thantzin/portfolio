import 'package:flutter/material.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';

class AnimatedTextShadowButton extends StatefulWidget {
  const AnimatedTextShadowButton({
    super.key,
    required this.title,
    this.onTap,
    this.textStyle,
    this.shadowColor = kBlueAccent,
    this.duration = duration300,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.backgroundColor = kBlack,
    this.borderRadius = 12.0,
  });

  final String title;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color shadowColor;
  final Duration duration;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double borderRadius;

  @override
  State<AnimatedTextShadowButton> createState() =>
      _AnimatedTextShadowButtonState();
}

class _AnimatedTextShadowButtonState extends State<AnimatedTextShadowButton>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      fontSize: s20,
      fontWeight: bold,
      color: kWhite,
    );

    return MouseRegion(
      key: ValueKey('MouseRegion_Animated_Text_Shadow'),
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: widget.duration,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: widget.shadowColor.withValues(alpha: 0.6),
                      blurRadius: context.autoAdaptive(s20),
                      spreadRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : [],
          ),
          child: AnimatedDefaultTextStyle(
            duration: widget.duration,
            style: (widget.textStyle ?? defaultTextStyle).copyWith(
              shadows: _isHovering
                  ? [
                      Shadow(
                        color: widget.shadowColor,
                        offset: const Offset(0, 0),
                        blurRadius: context.autoAdaptive(s14),
                      ),
                      Shadow(
                        color: widget.shadowColor.withValues(alpha: 0.5),
                        offset: const Offset(2, 2),
                        blurRadius: context.autoAdaptive(s10),
                      ),
                    ]
                  : [],
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
