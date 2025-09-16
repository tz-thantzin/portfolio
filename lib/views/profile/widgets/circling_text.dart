import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';

import '../../../presentations/configs/constant_sizes.dart';

class CirclingText extends StatefulWidget {
  final String text;
  final double radius;
  final TextStyle? textStyle;
  final Duration duration;
  final double minLetterPadding;
  final bool clockwise;

  const CirclingText(
    this.text, {
    super.key,
    this.radius = s100,
    this.textStyle,
    this.duration = duration10000,
    this.minLetterPadding = 2.0,
    this.clockwise = false,
  });

  @override
  State<CirclingText> createState() => _CirclingTextState();
}

class _CirclingTextState extends State<CirclingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<double> _charWidths;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();

    final TextStyle effectiveStyle =
        widget.textStyle ?? const TextStyle(fontSize: 14);

    // Cache character widths to improve performance
    _charWidths = widget.text.runes
        .map((r) => _measureCharWidth(String.fromCharCode(r), effectiveStyle))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _measureCharWidth(String char, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: char, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return tp.width;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text.isEmpty) return const SizedBox();

    final TextStyle effectiveStyle =
        widget.textStyle ?? DefaultTextStyle.of(context).style;
    final double fontSize = effectiveStyle.fontSize ?? 14;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double rotation =
            (widget.clockwise ? 1 : -1) * _controller.value * 2 * math.pi;

        // Compute arc lengths
        final List<double> arcLengths = _charWidths
            .map((w) => w + widget.minLetterPadding)
            .toList();
        final double totalArc = arcLengths.fold(0.0, (a, b) => a + b);

        // Compute radius to fit text
        final double radius = math.max(widget.radius, totalArc / (2 * math.pi));

        final double circumference = 2 * math.pi * radius;
        final double startArcOffset = -totalArc / 2;
        double cumulativeArc = startArcOffset;

        final List<Widget> letters = [];

        for (int i = 0; i < widget.text.length; i++) {
          final double halfArc = arcLengths[i] / 2;
          cumulativeArc += halfArc;

          final double angle =
              (cumulativeArc / circumference) * 2 * math.pi + rotation;

          final Offset offset = Offset(
            radius * math.cos(angle),
            radius * math.sin(angle),
          );

          final double glyphRotation = angle + math.pi / 2;

          letters.add(
            Transform.translate(
              offset: offset,
              child: Transform.rotate(
                angle: glyphRotation,
                child: Text(
                  String.fromCharCode(widget.text.runes.elementAt(i)),
                  style: effectiveStyle,
                ),
              ),
            ),
          );

          cumulativeArc += halfArc;
        }

        return ClipRect(
          child: SizedBox(
            width: (radius + fontSize * 1.5) * 2,
            height: (radius + fontSize * 1.5) * 2,
            child: Stack(alignment: Alignment.center, children: letters),
          ),
        );
      },
    );
  }
}
