import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data/contact_data.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:provider/provider.dart';

import '../../models/contact.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../view_models/home_view_model.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  IconData? _getIcon(String name) {
    switch (name.toLowerCase()) {
      case 'email':
        return Icons.email;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'github':
        return FontAwesomeIcons.github;
      default:
        return Icons.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Contact> contactList = footerContacts();

    return Container(
      color: kFooterBg,
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s24.w, vertical: s16.h),
        child: Column(
          children: [
            Text(
              '© 2025 Thant Zin. All rights reserved.',
              style: context.footerTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox().verticalSpaceMedium,
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
                  child: SizedBox(
                    width: s40.r,
                    height: s40.r * 1.1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // Animated background circle
                        Container(
                          width: s40.r,
                          height: s40.r,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                        ),
                        // Icon
                        Icon(
                          _getIcon(contactList[i].name),
                          color: kGrey300,
                          size: s30.r,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
