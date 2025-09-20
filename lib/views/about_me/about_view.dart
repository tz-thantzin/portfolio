import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../widgets/animated_fade_widget.dart';
import 'about_description.dart';
import 'about_image.dart';
import 'technology_grid.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_hasAnimated && mounted) {
      Future.delayed(duration500, () {
        if (mounted) _controller.forward();
      });
      _hasAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s60),
        vertical: context.autoAdaptive(s65),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          verticalSpaceMassive,
          _buildTechnologyGrid(),
        ],
      ),
    ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged);
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = context.isMobile;

    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isMobile)
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.0,
            end: 0.4,
            child: const AboutImage(),
          )
        else
          Expanded(
            flex: 1,
            child: AnimatedFadeWidget(
              controller: _controller,
              start: 0.0,
              end: 0.4,
              child: const AboutImage(),
            ),
          ),
        if (isMobile)
          AnimatedFadeWidget(
            controller: _controller,
            start: 0.3,
            end: 0.7,
            child: const AboutDescription(),
          )
        else
          Expanded(
            flex: 2,
            child: AnimatedFadeWidget(
              controller: _controller,
              start: 0.3,
              end: 0.7,
              child: const AboutDescription(),
            ),
          ),
      ],
    );
  }

  Widget _buildTechnologyGrid() {
    return AnimatedFadeWidget(
      controller: _controller,
      start: 0.6,
      end: 1.0,
      child: const TechnologyGrid(),
    );
  }
}
