import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../l10n/app_localizations.dart';
import '../../style_theme.dart';
import '../../utils/constants.dart';

class NavBar extends StatelessWidget {
  final Function(String) onNavItemClicked;
  final VoidCallback toggleTheme;
  final VoidCallback toggleNavDrawer;
  final ValueChanged<Locale> setLocale;
  final ThemeMode themeMode;
  final Locale? locale;
  final String selectedSection;

  const NavBar({
    required this.onNavItemClicked,
    required this.toggleTheme,
    required this.toggleNavDrawer,
    required this.themeMode,
    required this.setLocale,
    required this.selectedSection,
    this.locale,
    super.key,
  });

  TextStyle _navItemStyle(BuildContext context, String sectionKey) {
    final bool isSelected = selectedSection == sectionKey;
    return isSelected
        ? AppTextStyle.navItemSelectedTextStyle(context)
        : AppTextStyle.navItemTextStyle(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < Constants.desktopSize;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: isMobile
          ? Builder(
              builder: (BuildContext context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.indigo),
                onPressed: toggleNavDrawer,
              ),
            )
          : null,
      title: Container(
        padding: EdgeInsets.symmetric(
          vertical: Paddings.paddingXXL.h,
          horizontal: Paddings.paddingS.w,
        ),
        child: Text(
          'Thant Zin',
          style: AppTextStyle.navTitleTextStyle(context),
        ),
      ),
      actions: <Widget>[
        if (!isMobile) ...<Widget>[
          TextButton(
            onPressed: () => onNavItemClicked(Constants.home),
            child: Text(
              AppLocalizations.of(context)!.home,
              style: _navItemStyle(context, Constants.home),
            ),
          ),
          TextButton(
            onPressed: () => onNavItemClicked(Constants.about),
            child: Text(
              AppLocalizations.of(context)!.about,
              style: _navItemStyle(context, Constants.about),
            ),
          ),
          TextButton(
            onPressed: () => onNavItemClicked(Constants.experience),
            child: Text(
              AppLocalizations.of(context)!.work_experience,
              style: _navItemStyle(context, Constants.experience),
            ),
          ),
          TextButton(
            onPressed: () => onNavItemClicked(Constants.education),
            child: Text(
              AppLocalizations.of(context)!.education,
              style: _navItemStyle(context, Constants.education),
            ),
          ),
          TextButton(
            onPressed: () => onNavItemClicked(Constants.skill),
            child: Text(
              AppLocalizations.of(context)!.skill,
              style: _navItemStyle(context, Constants.skill),
            ),
          ),
        ],
        SizedBox(width: Sizes.sizeXS.w),
        DropdownButtonHideUnderline(
          child: DropdownButton<Locale>(
            value: locale ?? const Locale('en'),
            focusColor: Colors.transparent,
            dropdownColor: Theme.of(context).cardColor,
            items: <DropdownMenuItem<Locale>>[
              DropdownMenuItem<Locale>(
                value: const Locale('en'),
                child: Row(
                  children: <Widget>[
                    const Text('🇺🇸'),
                    const SizedBox(width: 6),
                    Text(
                      'English',
                      style: AppTextStyle.navItemTextStyle(context),
                    ),
                  ],
                ),
              ),
              DropdownMenuItem<Locale>(
                value: const Locale('ja'),
                child: Row(
                  children: <Widget>[
                    const Text('🇯🇵'),
                    const SizedBox(width: 6),
                    Text('日本語', style: AppTextStyle.navItemTextStyle(context)),
                  ],
                ),
              ),
              DropdownMenuItem<Locale>(
                value: const Locale('th'),
                child: Row(
                  children: <Widget>[
                    const Text('🇹🇭'),
                    const SizedBox(width: 6),
                    Text('ไทย', style: AppTextStyle.navItemTextStyle(context)),
                  ],
                ),
              ),
            ],
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                setLocale(newLocale);
              }
              FocusScope.of(context).unfocus();
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(right: Sizes.sizeS.w),
          child: IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
              color: Colors.indigo,
            ),
            onPressed: toggleTheme,
            tooltip: themeMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode',
          ),
        ),
      ],
    );
  }
}
