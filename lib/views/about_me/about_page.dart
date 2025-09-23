import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/route/routes.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/about_me/about_specialization.dart';
import 'package:portfolio/views/footer/footer_view.dart';
import 'package:portfolio/views/widgets/text/typewrite_text.dart';
import 'package:portfolio/views/wrapper.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../widgets/animated_fade_widget.dart';
import 'about_description.dart';
import 'technology_grid.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _technologyAnimationController;
  final ScrollController _scrollController = ScrollController();

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
    _technologyAnimationController = AnimationController(
      vsync: this,
      duration: duration3000,
    );
    _listenAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    _technologyAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _listenAnimations() async {
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Future.delayed(duration500, () {
          if (mounted) _technologyAnimationController.forward();
        });
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.45 && !_hasAnimated && mounted) {
      Future.delayed(duration300, () {
        if (mounted) _controller.forward();
      });
      _hasAnimated = true;
    }
  }

  void _onTapScrollDown() {
    _scrollController.animateTo(
      context.screenHeight,
      duration: duration500,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      selectedRoute: RoutePaths.about,
      selectedPageName: RouteName.about,
      child: Column(
        children: [
          AboutSpecialization(onTapScrollDown: _onTapScrollDown),
          verticalSpaceMassive,
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.3,
            end: 0.7,
            child: const AboutDescription(),
          ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),
          verticalSpaceMassive,
          _buildTechnologyGrid(),
          verticalSpaceMassive,
          _buildQuote(context),
          FooterView(),
        ],
      ).addScrollView(controller: _scrollController),
    );
  }

  Widget _buildQuote(BuildContext context) {
    return AnimatedFadeWidget(
          controller: _controller,
          start: 0.6,
          end: 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TypewriterText(
                context.localization.quote,
                speed: duration50,
                style: GoogleFonts.playfair(
                  textStyle: context.titleLarge.copyWith(
                    fontSize: context.autoAdaptive(s32),
                    fontWeight: bold,
                  ),
                ),
              ),
              Text(
                '— ${context.localization.author}',
              ).addAlign(alignment: Alignment.centerRight),
            ],
          ),
        )
        .addPadding(
          padding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(s60),
            vertical: context.autoAdaptive(s50),
          ),
        )
        .addSizedBox(width: double.infinity);
  }

  Widget _buildTechnologyGrid() {
    return AnimatedFadeWidget(
      controller: _controller,
      start: 0.6,
      end: 0.9,
      child: TechnologyGrid(
        animationController: _technologyAnimationController,
      ),
    );
  }
}
