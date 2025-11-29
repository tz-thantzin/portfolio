import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/configs/configs.dart';
import '../../../core/di/providers.dart';
import '../../../utils/extensions/extensions.dart';
import '../../widgets/animated_slide_button.dart';
import '../../widgets/text/animated_typewriter_text.dart';
import '../../widgets/text/app_text.dart';
import '../../widgets/text/body_text.dart';
import '../../widgets/text/title_text.dart';

class IntroWidget extends ConsumerStatefulWidget {
  final VoidCallback onTapScrollDown;
  final AnimationController controller;

  const IntroWidget({
    super.key,
    required this.onTapScrollDown,
    required this.controller,
  });

  @override
  ConsumerState<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends ConsumerState<IntroWidget> {
  Animation<Offset> _getSlideAnim(double start, double end) {
    return Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(start, end, curve: Curves.easeOutBack),
      ),
    );
  }

  Animation<double> _getFadeAnim(double start, double end) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Staggered Timings
    final helloSlide = _getSlideAnim(0.0, 0.4);
    final helloFade = _getFadeAnim(0.0, 0.4);

    final nameFade = _getFadeAnim(0.2, 0.6); // Name fades in while typing

    final roleSlide = _getSlideAnim(0.5, 0.8);
    final roleFade = _getFadeAnim(0.5, 0.8);

    final btnSlide = _getSlideAnim(0.7, 1.0);
    final btnFade = _getFadeAnim(0.7, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 1. "Hi"
        SlideTransition(
          position: helloSlide,
          child: FadeTransition(
            opacity: helloFade,
            child: TitleText(
              context.localization.hi,
              fontSize: FontSize.small,
              color: kTomato,
              fontWeight: semiBold,
              style: const TextStyle(letterSpacing: 1.5),
            ),
          ),
        ),
        verticalSpaceSmall,

        // 2. Name Block
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SlideTransition(
              position: helloSlide,
              child: FadeTransition(
                opacity: helloFade,
                child: TitleText(
                  context.localization.i_am,
                  fontSize: FontSize.small,
                  color: kBlack,
                  fontWeight: bold,
                ),
              ),
            ),
            horizontalSpaceSmall,
            FadeTransition(
              opacity: nameFade,
              child: TypewriterText(
                context.localization.thantzin,
                style: context.titleLarge.copyWith(
                  color: kBlack,
                  fontSize: context.autoAdaptive(s48),
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
                startDelay: duration500,
              ),
            ),
          ],
        ),
        verticalSpaceMedium,

        // 3. Role Description
        SlideTransition(
          position: roleSlide,
          child: FadeTransition(
            opacity: roleFade,
            child: BodyText(
              context.localization.freelance_mobile_developer,
              textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
              color: kGrey700,
              height: 1.5,
              maxLines: 3,
            ),
          ),
        ),
        verticalSpaceMassive,

        // 4. Action Button
        SlideTransition(
          position: btnSlide,
          child: FadeTransition(
            opacity: btnFade,
            child: AnimatedSlideButton(
              height: context.autoAdaptive(s48),
              width: context.autoAdaptive(200),
              title: context.localization.download_resume.toUpperCase(),
              hasIcon: true,
              icon: Icons.download_rounded,
              buttonColor: kGrey900,
              textColor: kWhite,
              borderColor: kGrey900,
              onHoverColor: kWhite70,
              onPressed: () {
                ref.read(homeViewModelProvider).onDownloadResumeBtnPressed();
              },
            ),
          ),
        ),
      ],
    ).addPadding(
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(context.isMobile ? s0 : s24),
      ),
    );
  }
}
