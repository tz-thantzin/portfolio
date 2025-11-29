import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../core/routing/routes.dart';
import '../../utils/extensions/extensions.dart';
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
    // Controls the entrance of the IntroductionView elements
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // If no custom animation (navigating back), start entrance immediately
    if (!widget.showCustomAnimation) {
      _controller.forward();
    }
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
      duration: duration800,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _onLoadingDone() {
    // Start entrance animation after splash screen finishes
    if (mounted) _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      selectedRoute: RoutePaths.home,
      selectedPageName: RouteName.home,
      onLoadingAnimationDone: _onLoadingDone,
      customLoadingAnimation: widget.showCustomAnimation
          ? AnimatedLoadingPage(
              text: context.localization.thantzin,
              onLoadingDone: _onLoadingDone,
              lineColor: kGrey100,
              style: context.titleMedium.copyWith(color: kWhite),
            )
          : null,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(), // Better for web/desktop feel
        child: Column(
          children: [
            IntroductionView(
              animationController: _controller,
              onTapScrollDown: _onTapScrollDown,
            ),
            RecentProjectView(),
            FooterView(),
          ],
        ),
      ),
    );
  }
}
