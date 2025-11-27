import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/views/widgets/text/app_text.dart';
import 'package:portfolio/views/widgets/text/body_text.dart';
import 'package:portfolio/views/widgets/text/title_text.dart';

import '../../../core/di/providers.dart';
import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/duration.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';
import '../../../utils/extensions/widget_ex.dart';
import '../../widgets/animated_slide_button.dart';
import '../../widgets/text/animated_typewriter_text.dart';

class IntroWidget extends ConsumerStatefulWidget {
  final VoidCallback onTapScrollDown;
  const IntroWidget({super.key, required this.onTapScrollDown});

  @override
  ConsumerState<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends ConsumerState<IntroWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return <Widget>[
          TitleText(
            context.localization.hi,
            fontSize: FontSize.small,
            color: kBlack,
            fontWeight: semiBold,
          ),
          verticalSpaceSmall,

          <Widget>[
            TitleText(
              context.localization.i_am,
              fontSize: FontSize.small,
              color: kBlack,
              fontWeight: semiBold,
            ),
            horizontalSpaceSmall,
            TypewriterText(
              context.localization.thantzin,
              style: context.titleSmall.copyWith(
                color: kTomato,
                fontSize: context.autoAdaptive(s36),
              ),
              startDelay: duration3000,
            ),
          ].addRow(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          verticalSpaceSmall,
          BodyText(
            context.localization.freelance_mobile_developer,
            textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
            color: kGrey800,
          ),
          verticalSpaceMassive,
          <Widget>[
            AnimatedSlideButton(
              height: context.autoAdaptive(s36),
              title: context.localization.download_resume.toUpperCase(),
              hasIcon: false,
              buttonColor: kWhite,
              borderColor: kGrey900,
              onHoverColor: kGrey800,
              onPressed: () {
                ref.read(homeViewModelProvider).onDownloadResumeBtnPressed();
              },
            ),
          ].addRow(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ]
        .addColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
        )
        .addPadding(
          padding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(context.isMobile ? s0 : s24),
          ),
        );
  }
}
