import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_images.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/utils.dart';

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
            horizontal: context.autoAdaptive(s8),
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
                SelectableText(
                  experienceDuration,
                  style: GoogleFonts.abrilFatface(
                    textStyle: context.bodyLarge.copyWith(
                      fontSize: context.autoAdaptive(s32),
                      color: kTomato,
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                ContentText(
                  context.localization.years_success,
                  fontSize: context.autoAdaptive(s10),
                  textColor: kPrimary,
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
