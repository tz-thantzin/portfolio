import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';
import '../../style_theme.dart';
import '../../utils/constants.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final Function(String) onNavItemClicked;
  final VoidCallback onCloseDrawer;
  const CustomNavigationDrawer({
    required this.onNavItemClicked,
    required this.onCloseDrawer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: onCloseDrawer, // Dismiss on tap outside
          child: Container(color: Colors.transparent),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black26, blurRadius: 6.r),
            ],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.home,
                  style: AppTextStyle.navItemTextStyle(context),
                ),
                onTap: () => onNavItemClicked(Constants.home),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.about,
                  style: AppTextStyle.navItemTextStyle(context),
                ),
                onTap: () => onNavItemClicked(Constants.about),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.work_experience,
                  style: AppTextStyle.navItemTextStyle(context),
                ),
                onTap: () => onNavItemClicked(Constants.experience),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.education,
                  style: AppTextStyle.navItemTextStyle(context),
                ),
                onTap: () => onNavItemClicked(Constants.education),
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.skill,
                  style: AppTextStyle.navItemTextStyle(context),
                ),
                onTap: () => onNavItemClicked(Constants.skill),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
