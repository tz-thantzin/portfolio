import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_scale_widget.dart';

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
          child: AnimatedScaleWidget(
            child: SvgPicture.asset(
              kFlutterSVG,
              width: context.autoAdaptive(s42),
              height: context.autoAdaptive(s42),
            ),
          ),
        ),

        // Swift Icon
        Positioned(
          top: context.autoAdaptive(s20),
          left: context.autoAdaptive(s180),
          child: AnimatedScaleWidget(
            child: SvgPicture.asset(
              kSwiftNoBgSVG,
              width: context.autoAdaptive(s42),
              height: context.autoAdaptive(s42),
            ),
          ),
        ),

        // Firebase Icon
        Positioned(
          top: context.autoAdaptive(s165),
          left: context.autoAdaptive(s100),
          child: AnimatedScaleWidget(
            child: SvgPicture.asset(
              kFirebaseSVG,
              width: context.autoAdaptive(s42),
              height: context.autoAdaptive(s42),
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
