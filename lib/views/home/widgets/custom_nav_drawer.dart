import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

import '../../../presentations/configs/constants.dart';
import '../../../utils/extensions/context_ex.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final Function(String) onNavItemClicked;
  final VoidCallback onCloseDrawer;

  const CustomNavigationDrawer({
    required this.onNavItemClicked,
    required this.onCloseDrawer,
    super.key,
  });

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: widget.onCloseDrawer,
          child: Container(color: kTransparent),
        ),
        Container(
          width: context.screenWidth,
          decoration: BoxDecoration(color: kPrimary),
          margin: EdgeInsets.only(top: context.appBarHeight),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    context.localization.home,
                    style: context.navItemTextStyle.copyWith(color: kWhite),
                  ),
                  onTap: () => widget.onNavItemClicked(kHome),
                ),
                ListTile(
                  title: Text(
                    context.localization.about,
                    style: context.navItemTextStyle.copyWith(color: kWhite),
                  ),
                  onTap: () => widget.onNavItemClicked(kAbout),
                ),
                ListTile(
                  title: Text(
                    context.localization.work_experience,
                    style: context.navItemTextStyle.copyWith(color: kWhite),
                  ),
                  onTap: () => widget.onNavItemClicked(kExperience),
                ),
                ListTile(
                  title: Text(
                    context.localization.portfolio,
                    style: context.navItemTextStyle.copyWith(color: kWhite),
                  ),
                  onTap: () => widget.onNavItemClicked(kPortfolio),
                ),
                ListTile(
                  title: Text(
                    context.localization.education,
                    style: context.navItemTextStyle.copyWith(color: kWhite),
                  ),
                  onTap: () => widget.onNavItemClicked(kEducation),
                ),
                ListTile(
                  title: Text(
                    context.localization.skill,
                    style: context.navItemTextStyle.copyWith(color: kWhite),
                  ),
                  onTap: () => widget.onNavItemClicked(kSkill),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
