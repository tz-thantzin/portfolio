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
    final double drawerWidth = context.autoAdaptive(
      250,
    ); // responsive drawer width

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: widget.onCloseDrawer,
          child: Container(color: kTransparent),
        ),
        Container(
          width: drawerWidth,
          decoration: BoxDecoration(color: kPrimary),
          margin: EdgeInsets.only(top: context.appBarHeight),
          padding: EdgeInsets.symmetric(
            vertical: context.autoAdaptive(16),
            horizontal: context.autoAdaptive(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _navItem(context, context.localization.home, kHome),
                _navItem(context, context.localization.about, kAbout),
                _navItem(
                  context,
                  context.localization.work_experience,
                  kExperience,
                ),
                _navItem(context, context.localization.portfolio, kPortfolio),
                _navItem(context, context.localization.skill, kSkill),
                _navItem(context, context.localization.contact, kContact),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _navItem(BuildContext context, String title, String route) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(8),
        vertical: context.autoAdaptive(4),
      ),
      title: Text(title, style: context.bodyMedium.copyWith(color: kWhite)),
      onTap: () => widget.onNavItemClicked(route),
    );
  }
}
