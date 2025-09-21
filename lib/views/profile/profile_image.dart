import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_images.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../widgets/text/title_text.dart';

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
            vertical: context.autoAdaptive(s8),
          ),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(context.autoAdaptive(16)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kBlack.withValues(alpha: 0.05),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child:
              <Widget>[
                TitleText(
                  context.localization.year_of_work_experience,
                  fontSize: context.autoAdaptive(s20),
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
