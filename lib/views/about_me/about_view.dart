import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => AboutSectionState();
}

class AboutSectionState extends State<AboutSection>
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

    // Animation for the message (bottom to top)
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
    VisibilityDetectorController.instance.forget(Key('about_section'));

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return VisibilityDetector(
          key: Key('about_section'),
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
            padding: EdgeInsets.symmetric(horizontal: s24.w, vertical: s40.h),
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
                            child: AboutImage(),
                          )
                        : Expanded(
                            flex: 1,
                            child: AnimatedSlideWidget(
                              animation: _aboutImageAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: AboutImage(),
                            ),
                          ),
                    context.isMobile
                        ? AnimatedSlideWidget(
                            animation: _messagesAnimation,
                            fadeAnimation: _fadeAnimation,
                            child: AboutMessages(),
                          )
                        : Expanded(
                            flex: 2,
                            child: AnimatedSlideWidget(
                              animation: _messagesAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: AboutMessages(),
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
