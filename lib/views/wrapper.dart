import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../presentations/configs/constant_sizes.dart';
import '../presentations/configs/duration.dart';

class Wrapper extends StatefulWidget {
  final String selectedRoute;
  final String selectedPageName;
  final VoidCallback? onLoadingAnimationDone;
  final Widget customLoadingAnimation;
  final Widget child;

  const Wrapper({
    super.key,
    required this.selectedRoute,
    required this.selectedPageName,
    this.onLoadingAnimationDone,
    required this.customLoadingAnimation,
    required this.child,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with TickerProviderStateMixin {
  late AnimationController _loadingController;

  int sectors = 10;
  double screenWidth = s0;
  double sectorWidth = s0;

  final GlobalKey _globalKey = GlobalKey();

  final List<Interval> _itemSlideIntervals = [];

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    createStaggeredIntervals();
    _loadingController = AnimationController(
      vsync: this,
      duration: slideDuration,
    );
    screenWidth = context.screenWidth;
    sectorWidth = screenWidth / sectors;
  }

  @override
  void dispose() {
    _loadingController.dispose();
    super.dispose();
  }

  void _handleNavigation(String routeName) {
    _loadingController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      extendBodyBehindAppBar: true,
      body: <Widget>[].addStack(),
    );
  }
}
