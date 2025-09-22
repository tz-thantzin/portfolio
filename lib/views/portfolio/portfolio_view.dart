import 'dart:async';

import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/presentations/configs/constant_data.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/portfolio/project_card.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../widgets/animated_fade_widget.dart';
import '../widgets/text/title_text.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hasAnimated = false;

  final PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0.0;
  Timer? _autoScrollTimer;
  bool _userDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(duration5000, (_) {
      if (!_userDragging && mounted) {
        int nextPage = (_currentPage.floor() + 1) % projects().length;
        _pageController.animateToPage(
          nextPage,
          duration: duration500,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.45 && !_hasAnimated && mounted) {
      Future.delayed(duration500, () {
        if (mounted) {
          _controller.forward();
          _startAutoScroll();
        }
      });
      _hasAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectList = projects();

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s60),
        vertical: context.autoAdaptive(s50),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fade title
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.0,
            end: 0.5,
            child: TitleText(context.localization.portfolio),
          ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),
          verticalSpaceMassive,

          // PageView with drag detection (use AnimatedOpacity instead of FadeController for interaction)
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.6,
            end: 1,
            child: SizedBox(
              height: context.autoAdaptive(context.isMobile ? s300 : s200),
              child: Listener(
                onPointerDown: (_) => _userDragging = true,
                onPointerUp: (_) {
                  _userDragging = false;
                  _startAutoScroll(); // restart timer after drag
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: projectList.length,
                  itemBuilder: (context, i) {
                    final gradient =
                        kProjectCardGradients[i % kProjectCardGradients.length];
                    final textColor =
                        kProjectTextColor[i % kProjectTextColor.length];

                    double scale = 0.9;
                    double diff = (_currentPage - i).abs();
                    if (diff < 1) scale = 0.9 + (1 - diff) * 0.1;

                    return AnimatedScale(
                      scale: scale,
                      duration: duration300,
                      curve: Curves.easeOut,
                      child: ProjectCard(
                        projectList[i],
                        gradient: gradient,
                        textColor: textColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          verticalSpaceMedium,

          // Page indicators
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.6,
            end: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(projectList.length, (index) {
                double selectedness = (1 - (_currentPage - index).abs()).clamp(
                  0.0,
                  1.0,
                );
                double width = 12.0 + 12.0 * selectedness;

                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: duration500,
                      curve: Curves.easeInOut,
                    );
                    _startAutoScroll(); // reset timer
                  },
                  child: AnimatedContainer(
                    duration: duration300,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: width,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: selectedness > 0.5 ? kIndigo : kGrey300,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
