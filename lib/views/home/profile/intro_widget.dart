import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/constants.dart';
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
          Text(
            context.localization.hi,
            style: context.displayMedium.copyWith(
              color: kBlack,
              fontSize: context.autoAdaptive(s32),
            ),
          ),
          verticalSpaceSmall,
          <Widget>[
            Text(
              context.localization.i_am,
              style: context.displayMedium.copyWith(
                color: kBlack,
                fontSize: context.autoAdaptive(s32),
              ),
            ),
            horizontalSpaceSmall,
            TypewriterText(
              context.localization.thantzin,
              style: context.displayLarge.copyWith(
                color: kTomato,
                fontSize: context.autoAdaptive(s32),
              ),
              startDelay: duration3000,
            ),
          ].addRow(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          verticalSpaceSmall,
          Text(
            context.localization.freelance_mobile_developer,
            textHeightBehavior: textHeightBehavior,
            textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
            style: context.bodyLarge.copyWith(
              color: kGrey800,
              fontSize: context.autoAdaptive(16),
            ),
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
