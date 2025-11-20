import 'package:flutter/material.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/duration.dart';
import '../../../utils/extensions/theme_ex.dart';
import '../../../utils/extensions/widget_ex.dart';
import '../dotted_rectangle_painter.dart';
import 'animated_fade_in_text.dart';

class AnimatedHeaderText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration delay;
  final Duration duration;

  const AnimatedHeaderText({
    super.key,
    required this.text,
    this.style,
    this.delay = duration200,
    this.duration = duration2000,
  });

  @override
  State<AnimatedHeaderText> createState() => _AnimatedHeaderTextState();
}

class _AnimatedHeaderTextState extends State<AnimatedHeaderText>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _controller2;
  late final AnimationController _textController;
  late final Animation<double> _primaryTween;
  late final Animation<double> _whiteTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: duration3000)
      ..forward();
    _controller2 = AnimationController(vsync: this, duration: duration3000);
    _textController = AnimationController(vsync: this, duration: duration1000);

    _primaryTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _whiteTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller2, curve: Curves.fastOutSlowIn),
    );

    _startAnimations();
  }

  void _startAnimations() {
    Future.delayed(duration500, () => _controller2.forward());

    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(duration500, () => _textController.forward());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // Two stacked dotted rectangles
      <Widget>[
        ScaleTransition(
          scale: _primaryTween,
          child: CustomPaint(
            size: const Size(s200, s100),
            painter: DottedRectanglePainter(
              color: kPrimary,
              strokeWidth: 2,
              dashLength: 8,
              gapLength: 4,
            ),
          ),
        ),
        ScaleTransition(
          scale: _whiteTween,
          child: CustomPaint(
            size: const Size(s200, s100),
            painter: DottedRectanglePainter(
              color: kWhite,
              strokeWidth: 2,
              dashLength: 5,
              gapLength: 3,
            ),
          ),
        ),
      ].addStack().addSizedBox(width: s200, height: s100),

      // Animated fade-in text
      AnimatedFadeInText(
        widget.text,
        controller: _textController,
        style: widget.style ?? context.titleMedium.copyWith(fontSize: s30),
      ),
    ].addStack(alignment: Alignment.center);
  }
}
