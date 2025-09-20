import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/text/animated_fade_in_text.dart';
import 'package:provider/provider.dart';

import '../../models/social.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../view_models/home_view_model.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Social> contactList = contacts();

    return Container(
      color: kFooterBg,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s24),
        vertical: context.autoAdaptive(s16),
      ),
      child:
          <Widget>[
            AnimatedFadeInText(
              context.localization.let_work_together,
              style: GoogleFonts.poorStory(
                textStyle: context.titleLarge.copyWith(
                  color: kWhite,
                  fontSize: context.autoAdaptive(s48),
                ),
              ),
              delay: duration1000,
            ),
            verticalSpaceMedium,
            _SocialMedia(contactList: contactList),
            verticalSpaceMedium,
            Text(
              '© 2025 Thant Zin. All rights reserved.',
              style: context.bodySmall.copyWith(color: kGrey300),
              textAlign: TextAlign.center,
            ),
            verticalSpaceMedium,
            _BuiltWith(),
            verticalSpaceMedium,
          ].addColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
    );
  }
}

class _BuiltWith extends StatelessWidget {
  const _BuiltWith();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'Built using ',
          style: context.bodySmall.copyWith(color: kGrey300),
          textAlign: TextAlign.center,
        ),
        FlutterLogo(size: context.autoAdaptive(s14)),
        Text(
          " with ",
          style: context.bodySmall.copyWith(color: kGrey300),
          textAlign: TextAlign.center,
        ),
        horizontalSpaceTiny,
        Icon(
          FontAwesomeIcons.solidHeart,
          size: context.autoAdaptive(s14),
          color: kRed,
        ),
      ],
    );
  }
}

class _SocialMedia extends StatelessWidget {
  const _SocialMedia({required this.contactList});

  final List<Social> contactList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate(contactList.length, (int i) {
        return InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => context.read<HomeViewModel>().onContactMePressed(
            contactList[i].link,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: context.autoAdaptive(s8)),
            child: SizedBox(
              width: context.autoAdaptive(s20),
              height: context.autoAdaptive(s20),
              child: Icon(
                contactList[i].icon,
                color: kGrey300,
                size: context.autoAdaptive(s20),
              ),
            ),
          ),
        );
      }),
    );
  }
}
