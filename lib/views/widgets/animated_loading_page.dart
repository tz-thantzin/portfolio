import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/views/widgets/text/body_text.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';

class AnimatedLoadingPage extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback onLoadingDone;
  final Color? lineColor;

  const AnimatedLoadingPage({
    super.key,
    required this.text,
    this.style,
    required this.onLoadingDone,
    this.lineColor,
  });

  @override
  State<AnimatedLoadingPage> createState() => _AnimatedLoadingPageState();
}

class _AnimatedLoadingPageState extends State<AnimatedLoadingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _lineProgressAnimation;
  late final Animation<double> _lineWidthAnimation;

  final Duration _rippleDuration = duration2000;

  bool _isAnimationFinished = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _rippleDuration);

    _scaleAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _lineProgressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.linear),
      ),
    );

    _lineWidthAnimation = Tween<double>(begin: 50.0, end: 200.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.easeOutCubic,
        ), // Animates width early
      ),
    );

    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      _controller.forward().then((_) {
        if (!mounted) return;
        setState(() => _isAnimationFinished = true);
        widget.onLoadingDone();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAnimationFinished) {
      return const SizedBox.shrink();
    }

    final rippleColor = widget.lineColor ?? kBlack;
    final textColor = widget.style?.color ?? kWhite;

    return Container(
      color: kBlack,
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = _scaleAnimation.value;
          final opacity = _opacityAnimation.value;
          final lineProgress = _lineProgressAnimation.value;
          final currentLineWidth = _lineWidthAnimation.value;

          return Opacity(
            opacity: opacity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: scale * context.screenWidth / 100,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: rippleColor,
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BodyText(widget.text, style: widget.style),
                    verticalSpaceSmall,
                    Container(
                      width: currentLineWidth,
                      height: s4,
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: lineProgress,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: textColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
