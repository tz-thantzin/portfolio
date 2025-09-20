import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:provider/provider.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../view_models/home_view_model.dart';
import '../../presentations/configs/constants.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../widgets/animated_slide_button.dart';
import '../widgets/animated_text_button.dart';
import '../widgets/text/typewrite_text.dart';

class IntroWidget extends StatefulWidget {
  const IntroWidget({super.key});

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TextStyle? titleTextStyle = context.adaptive(
      Theme.of(context).textTheme.titleMedium,
      Theme.of(context).textTheme.headlineSmall,
      md: Theme.of(context).textTheme.titleLarge,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(s24)),
      child:
          <Widget>[
            Text(
              context.localization.hi,
              style: context.displayMedium.copyWith(
                color: kGrey1000,
                fontSize: context.autoAdaptive(s32),
              ),
            ),
            verticalSpaceSmall,
            <Widget>[
              Text(
                context.localization.i_am,
                style: context.displayMedium.copyWith(
                  color: kGrey1000,
                  fontSize: context.autoAdaptive(s32),
                ),
              ),
              horizontalSpaceSmall,
              TypewriterText(
                context.localization.thantzin,
                style: context.displayLarge.copyWith(
                  color: kIndigo,
                  fontSize: context.autoAdaptive(s32),
                ),
                startDelay: duration5000,
              ),
            ].addRow(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            verticalSpaceSmall,
            Text(
              context.localization.senior_mobile_developer,
              textHeightBehavior: textHeightBehavior,
              textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
              style: context.bodyLarge.copyWith(
                color: kGrey900,
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
              horizontalSpaceLarge,
              AnimatedTextButton(
                context.localization.see_my_work.toUpperCase(),
                hoverColor: kGrey700,
                textColor: kPrimary,
                onPressed: () {
                  context.read<HomeViewModel>().handleNavigation(kPortfolio);
                },
              ),
            ].addRow(
              mainAxisAlignment: context.isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ].addColumn(
            crossAxisAlignment: context.isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
    );
  }
}
