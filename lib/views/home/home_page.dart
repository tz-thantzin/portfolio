import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/route/routes.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/home/recent_projects/recent_project_view.dart';
import 'package:portfolio/views/widgets/animated_loading_page.dart';
import 'package:portfolio/views/wrapper.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/duration.dart';
import '../views.dart';

class HomePage extends StatefulWidget {
  final bool showCustomAnimation;
  const HomePage({super.key, this.showCustomAnimation = false});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTapScrollDown() {
    _scrollController.animateTo(
      context.screenHeight,
      duration: duration500,
      curve: Curves.easeInOut,
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.45 && mounted) {
      Future.delayed(duration300, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      selectedRoute: RoutePaths.home,
      selectedPageName: RouteName.home,
      customLoadingAnimation: widget.showCustomAnimation
          ? AnimatedLoadingPage(
              text: context.localization.thantzin,
              onLoadingDone: () {},
              lineColor: kGrey100,
              style: context.titleMedium.copyWith(color: kWhite),
            )
          : null,

      child: Column(
        children: [
          IntroductionView(
            animationController: _controller,
            onTapScrollDown: _onTapScrollDown,
          ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged),
          RecentProjectView(),
          FooterView(),
        ],
      ).addScrollView(controller: _scrollController),
    );
  }
}
