import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
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
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.autoAdaptive(s24),
          vertical: context.autoAdaptive(s16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                    margin: EdgeInsets.symmetric(
                      horizontal: context.autoAdaptive(s8),
                    ),
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
            ),
            SizedBox().verticalSpaceMedium,
            Text(
              '© 2025 Thant Zin. All rights reserved.',
              style: context.bodySmall.copyWith(color: kGrey300),
              textAlign: TextAlign.center,
            ),
            SizedBox().verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Built using ',
                  style: context.bodySmall.copyWith(color: kGrey300),
                  textAlign: TextAlign.center,
                ),
                FlutterLogo(size: 14),
                Text(
                  " with ",
                  style: context.bodySmall.copyWith(color: kGrey300),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  FontAwesomeIcons.solidHeart,
                  size: context.autoAdaptive(s14),
                  color: kRed,
                ),
              ],
            ),
            SizedBox().verticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}
