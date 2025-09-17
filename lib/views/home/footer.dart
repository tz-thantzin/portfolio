import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        padding: EdgeInsets.symmetric(horizontal: s24.w, vertical: s16.h),
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
                    margin: EdgeInsets.symmetric(horizontal: s8.w),
                    child: SizedBox(
                      width: s40.r,
                      height: s40.r * 1.1,
                      child: Icon(
                        contactList[i].icon,
                        color: kGrey300,
                        size: s30.r,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox().verticalSpaceMedium,
            Text(
              '© 2025 Thant Zin. All rights reserved.',
              style: context.footerTextStyle,
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
                  style: context.footerTextStyle,
                  textAlign: TextAlign.center,
                ),
                FlutterLogo(size: 14),
                Text(
                  " with ",
                  style: context.footerTextStyle,
                  textAlign: TextAlign.center,
                ),
                Icon(FontAwesomeIcons.solidHeart, size: s14.r, color: kRed),
              ],
            ),
            SizedBox().verticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}
