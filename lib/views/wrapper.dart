import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/route/routes.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_loading_slider.dart';
import 'package:provider/provider.dart';

import '../presentations/configs/constant_sizes.dart';
import '../presentations/configs/duration.dart';
import '../view_models/home_view_model.dart';
import 'home/widgets/custom_nav_drawer.dart';
import 'home/widgets/nav_bar.dart';

class Wrapper extends StatefulWidget {
  final String selectedRoute;
  final String selectedPageName;
  final VoidCallback? onLoadingAnimationDone;
  final Widget? customLoadingAnimation;
  final Widget child;

  const Wrapper({
    super.key,
    required this.selectedRoute,
    required this.selectedPageName,
    this.onLoadingAnimationDone,
    this.customLoadingAnimation,
    required this.child,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _menuController;

  int sectors = 10;
  double screenWidth = s0;
  double sectorWidth = s0;

  final GlobalKey _globalKey = GlobalKey();

  final List<Interval> _itemSlideIntervals = [];
  bool _isAnimating = false;
  bool _showChild = true;

  Duration get staggeredDuration => duration50;
  Duration get itemSlideDuration => duration1000;
  Duration get labelDuration => duration1000;
  Duration get slideDuration =>
      staggeredDuration +
      (staggeredDuration * sectors) +
      itemSlideDuration +
      duration200;

  void createStaggeredIntervals() {
    for (int i = 0; i < sectors; i++) {
      final Duration start = staggeredDuration + (staggeredDuration * i);
      final Duration end = start + itemSlideDuration;
      _itemSlideIntervals.add(
        Interval(
          start.inMilliseconds / slideDuration.inMilliseconds,
          end.inMilliseconds / slideDuration.inMilliseconds,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createStaggeredIntervals();
    _loadingController = AnimationController(
      vsync: this,
      duration: slideDuration,
    );
    _menuController = AnimationController(vsync: this, duration: duration1000);
    screenWidth = context.screenWidth;
    sectorWidth = screenWidth / sectors;

    if (widget.customLoadingAnimation == null) {
      _startLoadingAnimation();
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _menuController.dispose();
    super.dispose();
  }

  void _startLoadingAnimation() {
    setState(() {
      _showChild = false;
      _isAnimating = true;
    });
    _loadingController.forward();
    _loadingController.forward(from: 0).then((_) {
      setState(() {
        _showChild = true;
        _isAnimating = false;
      });
      if (widget.onLoadingAnimationDone != null) {
        widget.onLoadingAnimationDone!();
      }
    });
  }

  void _handleNavigation(String routeName) {
    final state = GoRouterState.of(context);
    if (state.name == routeName) return;

    final homeViewModel = context.read<HomeViewModel>();
    homeViewModel.closeDrawer();

    setState(() => _showChild = false);

    if (routeName == RouteName.home) {
      GoRouter.of(context).goNamed(
        routeName,
        extra: NavigationArguments(showCustomAnimation: false),
      );
    } else {
      GoRouter.of(context).goNamed(routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      extendBodyBehindAppBar: true,
      backgroundColor: kWhite,
      body: <Widget>[
        if (_showChild) ...[
          widget.child,
          Consumer<HomeViewModel>(
            builder: (_, homeViewModel, _) => NavBar(
              selectedSection: widget.selectedPageName,
              onNavItemClicked: _handleNavigation,
              onMenuTap: homeViewModel.toggleDrawer,
              controller: _menuController,
            ),
          ),
          Consumer<HomeViewModel>(
            builder: (_, HomeViewModel homeViewModel, _) => Visibility(
              visible: homeViewModel.isDrawerOpen,
              child: MenuView(
                onCloseDrawer: homeViewModel.closeDrawer,
                onNavItemClicked: (String routeName) {
                  homeViewModel.toggleDrawer();
                  _handleNavigation(routeName);
                },
              ),
            ),
          ),
        ],
        // slide overlay
        widget.customLoadingAnimation ?? const SizedBox.shrink(),
        if (_isAnimating)
          <Widget>[
            ...List.generate(
              sectors,
              (index) => LoadingSliderTransition(
                controller: _loadingController,
                height: context.screenHeight,
                width: sectorWidth,
                boxColor: kBlack,
                coverColor: kWhite,
                index: index,
                slideInterval: _itemSlideIntervals[index],
              ),
            ),
          ].addRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
      ].addStack(),
    );
  }
}
