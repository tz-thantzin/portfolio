import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/configs/configs.dart';
import '../../core/routing/routes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../../views/home/recent_projects/recent_project_view.dart';
import '../../views/widgets/animated_loading_page.dart';
import '../../views/wrapper.dart';
import '../footer/footer_view.dart';
import 'profile/introduction_view.dart';

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
