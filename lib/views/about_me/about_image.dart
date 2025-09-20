import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../../presentations/configs/constant_images.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/layout_adapter_ex.dart';

class AboutImage extends StatelessWidget {
  const AboutImage({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop ? const _DesktopView() : const _MobileView();
  }
}

class _DesktopView extends StatefulWidget {
  const _DesktopView();

  @override
  State<_DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<_DesktopView> {
  bool _isFlutterHovered = false;
  bool _isSwiftHovered = false;
  bool _isFirebaseHovered = false;

  @override
  Widget build(BuildContext context) {
    final double size = context.autoAdaptive(s250);

    return SizedBox(
      width: size,
      height: size,
      child: <Widget>[
        // Base image
        AspectRatio(
          aspectRatio: 1,
          child: Image.asset(kAboutMeIcon, fit: BoxFit.contain),
        ).addSizedBox(height: size),

        // Flutter Icon
        Positioned(
          top: context.autoAdaptive(s80),
          left: context.autoAdaptive(s20),
          child: MouseRegion(
            key: ValueKey('MouseRegion_Flutter_Icon'),
            onEnter: (_) => setState(() => _isFlutterHovered = true),
            onExit: (_) => setState(() => _isFlutterHovered = false),
            child: AnimatedScale(
              scale: _isFlutterHovered ? 1.5 : 1.0,
              duration: duration300,
              curve: Curves.easeOut,
              child: Image.asset(
                kFlutterIcon,
                width: context.autoAdaptive(s42),
                height: context.autoAdaptive(s42),
              ),
            ),
          ),
        ),

        // Swift Icon
        Positioned(
          top: context.autoAdaptive(s20),
          left: context.autoAdaptive(s180),
          child: MouseRegion(
            key: ValueKey('MouseRegion_Swift_Icon'),
            onEnter: (_) => setState(() => _isSwiftHovered = true),
            onExit: (_) => setState(() => _isSwiftHovered = false),
            child: AnimatedScale(
              scale: _isSwiftHovered ? 1.5 : 1.0,
              duration: duration300,
              curve: Curves.easeOut,
              child: Image.asset(
                kSwiftIcon,
                width: context.autoAdaptive(s42),
                height: context.autoAdaptive(s42),
              ),
            ),
          ),
        ),

        // Firebase Icon
        Positioned(
          top: context.autoAdaptive(s165),
          left: context.autoAdaptive(s100),
          child: MouseRegion(
            key: ValueKey('MouseRegion_Firebase_Icon'),
            onEnter: (_) => setState(() => _isFirebaseHovered = true),
            onExit: (_) => setState(() => _isFirebaseHovered = false),
            child: AnimatedScale(
              scale: _isFirebaseHovered ? 1.5 : 1.0,
              duration: duration300,
              curve: Curves.easeOut,
              child: Image.asset(
                kFirebaseIcon,
                width: context.autoAdaptive(s42),
                height: context.autoAdaptive(s42),
              ),
            ),
          ),
        ),
      ].addStack(),
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    final double size = context.autoAdaptive(s250);
    return AspectRatio(
      aspectRatio: 1,
      child: Image.asset(kAboutMeIcon, fit: BoxFit.contain),
    ).addSizedBox(height: size);
  }
}
