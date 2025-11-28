import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/configs/configs.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/utils.dart';
import '../../widgets/text/app_text.dart';
import '../../widgets/text/body_text.dart';
import '../../widgets/text/title_text.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop ? _DesktopView() : _MobileView();
  }
}

class _DesktopView extends StatelessWidget {
  const _DesktopView();

  @override
  Widget build(BuildContext context) {
    final double size = context.autoAdaptive(s350);
    final String experienceDuration = calculateWorkExperience(
      DateTime(2014, 2),
    );

    return <Widget>[
      AspectRatio(
        aspectRatio: 1,
        child: Image.asset(kTZ, fit: BoxFit.contain),
      ).addSizedBox(height: size),
      Positioned(
        top: context.autoAdaptive(s40),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(s12),
            vertical: context.autoAdaptive(s4),
          ),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(context.autoAdaptive(s12)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kBlack.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child:
              <Widget>[
                TitleText(
                  experienceDuration,
                  fontSize: FontSize.small,
                  color: kTomato,
                  style: GoogleFonts.abrilFatface(),
                ),
                horizontalSpaceSmall,
                BodyText(
                  context.localization.years_success,
                  fontSize: FontSize.small,
                  color: kPrimary,
                ),
              ].addRow(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
        ),
      ),
    ].addStack().addSizedBox(width: size, height: size);
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    final double size = context.autoAdaptive(s350);

    return AspectRatio(
      aspectRatio: 1,
      child: Image.asset(kTZ, fit: BoxFit.contain),
    ).addSizedBox(height: size);
  }
}
