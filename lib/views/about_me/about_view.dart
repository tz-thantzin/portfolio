import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/animated_slide_widget.dart';
import 'about_image.dart';
import 'about_message.dart';
import 'technology_grid.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => AboutViewState();
}

class AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _aboutImageAnimation;
  late Animation<Offset> _messagesAnimation;
  late Animation<Offset> _technologyGridAnimation;
  late Animation<double> _fadeAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000);

    // Animation for the image (left to right)
    _aboutImageAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animation for the message (right to left)
    _messagesAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animation for the grid (bottom to top)
    _technologyGridAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    VisibilityDetectorController.instance.forget(const Key('about_section'));
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return VisibilityDetector(
          key: const Key('about_section'),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction > 0.2 && !_hasAnimated && mounted) {
              _controller.forward();
              _hasAnimated = true;
            }
          },
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: context.screenHeight),
            color: kPrimary,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: context.autoAdaptive(s100),
              vertical: context.autoAdaptive(s65),
            ),
            child: Column(
              children: <Widget>[
                Flex(
                  direction: context.isMobile ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    context.isMobile
                        ? AnimatedSlideWidget(
                            animation: _aboutImageAnimation,
                            fadeAnimation: _fadeAnimation,
                            child: const AboutImage(),
                          )
                        : Expanded(
                            flex: 1,
                            child: AnimatedSlideWidget(
                              animation: _aboutImageAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: const AboutImage(),
                            ),
                          ),
                    context.isMobile
                        ? AnimatedSlideWidget(
                            animation: _messagesAnimation,
                            fadeAnimation: _fadeAnimation,
                            child: const AboutMessages(),
                          )
                        : Expanded(
                            flex: 2,
                            child: AnimatedSlideWidget(
                              animation: _messagesAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: const AboutMessages(),
                            ),
                          ),
                  ],
                ),
                SizedBox().verticalSpaceMassive,
                AnimatedSlideWidget(
                  animation: _technologyGridAnimation,
                  fadeAnimation: _fadeAnimation,
                  child: TechnologyGrid(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
