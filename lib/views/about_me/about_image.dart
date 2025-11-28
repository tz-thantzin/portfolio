import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../views/widgets/animated_scale_widget.dart';

class AboutImage extends StatelessWidget {
  const AboutImage({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerSize = context.autoAdaptive(s350);

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Stack(
        children: [
          // 1. Base background image
          Center(
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                kAboutMeIcon,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          // 2. Flutter Icon
          Positioned(
            top: context.autoAdaptive(s80),
            left: context.autoAdaptive(s20),
            child: AnimatedScaleWidget(
              child: SvgPicture.asset(
                kFlutterSVG,
                width: context.autoAdaptive(s50),
                height: context.autoAdaptive(s50),
              ),
            ),
          ),

          // 3. Swift Icon
          Positioned(
            top: context.autoAdaptive(s20),
            left: context.autoAdaptive(s250),
            child: AnimatedScaleWidget(
              child: SvgPicture.asset(
                kSwiftNoBgSVG,
                width: context.autoAdaptive(s50),
                height: context.autoAdaptive(s50),
              ),
            ),
          ),

          // 4. Firebase Icon
          Positioned(
            top: context.autoAdaptive(s220),
            left: context.autoAdaptive(s150),
            child: AnimatedScaleWidget(
              child: SvgPicture.asset(
                kFirebaseSVG,
                width: context.autoAdaptive(s50),
                height: context.autoAdaptive(s50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
