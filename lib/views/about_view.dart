import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../l10n/app_localizations.dart';
import '../style_theme.dart';
import '../utils/constants.dart';
import 'widgets/animated_slide_widget.dart';
import 'widgets/technology_grid.dart';
import 'widgets/text/content_text.dart';
import 'widgets/text/title_text.dart';

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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < Constants.desktopSize;
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
            padding: EdgeInsets.symmetric(
              vertical: Paddings.paddingXXL.h,
              horizontal: Paddings.paddingL.w,
            ),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    isMobile
                        ? AnimatedSlideWidget(
                            animation: _aboutImageAnimation,
                            fadeAnimation: _fadeAnimation,
                            child: _AboutImage(isMobile),
                          )
                        : Expanded(
                            flex: 1,
                            child: AnimatedSlideWidget(
                              animation: _aboutImageAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: _AboutImage(isMobile),
                            ),
                          ),
                    isMobile
                        ? AnimatedSlideWidget(
                            animation: _messagesAnimation,
                            fadeAnimation: _fadeAnimation,
                            child: _Messages(isMobile),
                          )
                        : Expanded(
                            flex: 2,
                            child: AnimatedSlideWidget(
                              animation: _messagesAnimation,
                              fadeAnimation: _fadeAnimation,
                              child: _Messages(isMobile),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: Sizes.sizeXL.h),
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

class _Messages extends StatelessWidget {
  const _Messages(this.isMobile);
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.sizeL.w),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleText(AppLocalizations.of(context)!.about_me),
          SizedBox(height: Sizes.sizeM.h),
          ContentText(AppLocalizations.of(context)!.about_me_description),
        ],
      ),
    );
  }
}

class _AboutImage extends StatelessWidget {
  const _AboutImage(this.isMobile);
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final double? size = isMobile ? 250.r : 450.r;
    return SizedBox(
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(ImagePath.aboutMeImagePath, fit: BoxFit.contain),
      ),
    );
  }
}
