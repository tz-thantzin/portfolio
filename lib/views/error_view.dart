import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';
import 'package:portfolio/route/routes.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_slide_button.dart';

class ErrorView extends StatefulWidget {
  const ErrorView({super.key});

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bounceAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -30.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -30.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: Text(
                    "404",
                    style: context.displayLarge.copyWith(
                      fontSize: context.autoAdaptive(120),
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                ),
                SizedBox(height: s16),
                Opacity(
                  opacity: _fadeAnimation.value,
                  child: Text(
                    context.localization.page_not_found.toUpperCase(),
                    style: context.headlineLarge.copyWith(
                      fontSize: context.autoAdaptive(24),
                      color: kWhite70,
                    ),
                  ),
                ),
                const SizedBox().verticalSpaceMassive,
                AnimatedSlideButton(
                  height: context.autoAdaptive(36),
                  title: context.localization.go_home.toUpperCase(),
                  hasIcon: false,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RoutePaths.home),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
