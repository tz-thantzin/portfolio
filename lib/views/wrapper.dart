import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/providers.dart';
import '../../core/routing/routes.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../utils/extensions/context_ex.dart';
import '../../views/widgets/animated_loading_slider.dart';

import '../presentations/configs/duration.dart';
import 'home/widgets/custom_nav_drawer.dart';
import 'home/widgets/nav_bar.dart';

class Wrapper extends ConsumerStatefulWidget {
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
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper>
    with TickerProviderStateMixin {
  late final AnimationController _loadingController;
  late final AnimationController _menuController;

  static const int _sectors = 10;
  final List<Interval> _slideIntervals = [];
  final GlobalKey _scaffoldKey = GlobalKey();

  bool _isAnimating = false;
  bool _showContent = true;

  Duration get _totalDuration =>
      duration50 * (1 + _sectors) + duration1000 + duration200;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: _totalDuration,
    );
    _menuController = AnimationController(vsync: this, duration: duration1000);

    _buildSlideIntervals();
    if (widget.customLoadingAnimation == null) _startLoadingAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _buildSlideIntervals(); // Rebuild on screen size change
  }

  void _buildSlideIntervals() {
    _slideIntervals.clear();
    final double totalMs = _totalDuration.inMilliseconds.toDouble();

    for (int i = 0; i < _sectors; i++) {
      final start = (duration50 + duration50 * i).inMilliseconds / totalMs;
      final end =
          (duration50 + duration50 * i + duration1000).inMilliseconds / totalMs;
      _slideIntervals.add(Interval(start, end, curve: Curves.easeOut));
    }
  }

  void _startLoadingAnimation() {
    setState(() {
      _showContent = false;
      _isAnimating = true;
    });

    _loadingController.forward(from: 0).then((_) {
      if (!mounted) return;
      setState(() {
        _showContent = true;
        _isAnimating = false;
      });
      widget.onLoadingAnimationDone?.call();
    });
  }

  void _navigateTo(String routeName) {
    if (GoRouterState.of(context).name == routeName) return;

    ref.read(homeViewModelProvider).closeDrawer();
    setState(() => _showContent = false);

    final router = GoRouter.of(context);
    if (routeName == RouteName.home) {
      router.goNamed(
        routeName,
        extra: NavigationArguments(showCustomAnimation: false),
      );
    } else {
      router.goNamed(routeName);
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeVm = ref.watch(homeViewModelProvider);
    final sectorWidth = context.screenWidth / _sectors;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Main content + Nav + Drawer
          if (_showContent) ...[
            widget.child,
            NavBar(
              selectedSection: widget.selectedPageName,
              onNavItemClicked: _navigateTo,
              onMenuTap: homeVm.toggleDrawer,
              controller: _menuController,
            ),
            if (homeVm.isDrawerOpen)
              MenuView(
                onCloseDrawer: homeVm.closeDrawer,
                onNavItemClicked: (route) {
                  homeVm.toggleDrawer();
                  _navigateTo(route);
                },
              ),
          ],

          // Custom loading (e.g. first launch)
          widget.customLoadingAnimation ?? const SizedBox.shrink(),

          // Slider loading overlay
          if (_isAnimating)
            Row(
              children: List.generate(
                _sectors,
                (i) => LoadingSliderTransition(
                  controller: _loadingController,
                  height: context.screenHeight,
                  width: sectorWidth,
                  boxColor: kBlack,
                  coverColor: kWhite,
                  index: i,
                  slideInterval: _slideIntervals[i],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
