import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:provider/provider.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/constants.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../view_models/home_view_model.dart';
import '../../widgets/animated_slide_button.dart';
import '../../widgets/text/typewrite_text.dart';

class IntroWidget extends StatefulWidget {
  final VoidCallback onTapScrollDown;
  const IntroWidget({super.key, required this.onTapScrollDown});

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget>
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
            context.read<HomeViewModel>().onDownloadResumeBtnPressed();
          },
        ),
      ].addRow(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    ].addColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
