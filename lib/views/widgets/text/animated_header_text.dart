import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../../utils/extensions/extensions.dart';
import '../dotted_rectangle_painter.dart';
import 'animated_fade_in_text.dart';

class AnimatedHeaderText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final AnimationController controller; // Requires controller from parent

  const AnimatedHeaderText({
    super.key,
    required this.text,
    required this.controller,
    this.style,
  });

  @override
  State<AnimatedHeaderText> createState() => _AnimatedHeaderTextState();
}

class _AnimatedHeaderTextState extends State<AnimatedHeaderText>
    with TickerProviderStateMixin {
  late final Animation<double> _scaleAnimation;
  late final AnimationController _textController;

  @override
  void initState() {
    super.initState();

    // Re-use the parent controller's duration for the box scale-up effect
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    // Dedicated controller for staggered text reveal
    _textController = AnimationController(vsync: this, duration: duration1000);

    // Start text animation after the box animation begins/progresses
    widget.controller.addListener(_startTextAnimation);
  }

  void _startTextAnimation() {
    if (widget.controller.value > 0.3 &&
        !_textController.isAnimating &&
        !_textController.isCompleted) {
      _textController.forward();
      // Remove listener once text animation is triggered
      widget.controller.removeListener(_startTextAnimation);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    widget.controller.removeListener(_startTextAnimation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Subtle Dotted Rectangle Box
        ScaleTransition(
          scale: _scaleAnimation,
          child: CustomPaint(
            size: context.isMobile
                ? Size(context.autoAdaptive(s250), context.autoAdaptive(s150))
                : Size(context.autoAdaptive(s350), context.autoAdaptive(s180)),
            painter: DottedRectanglePainter(
              color: kBlack.withValues(alpha: 0.5), // Subtle color
              strokeWidth: 1.5,
              dashLength: 5,
              gapLength: 3,
            ),
          ),
        ),

        // Animated fade-in text
        AnimatedFadeInText(
          widget.text,
          controller: _textController,
          style:
              widget.style ??
              context.titleMedium.copyWith(
                fontSize: context.autoAdaptive(s32),
                fontWeight: bold,
                color: kBlack,
              ),
        ),
      ],
    );
  }
}
