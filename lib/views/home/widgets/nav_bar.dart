import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/constants.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';

class NavBar extends StatefulWidget {
  final Function(String) onNavItemClicked;
  final VoidCallback toggleNavDrawer;
  final String selectedSection;
  final ScrollController scrollController;

  const NavBar({
    required this.onNavItemClicked,
    required this.toggleNavDrawer,
    required this.selectedSection,
    required this.scrollController,
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      scrollOffset = widget.scrollController.offset;
    });
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  Color _getAppBarColor(BuildContext context) {
    final double opacity = (scrollOffset / 200).clamp(0.0, 1.0);
    return kPrimary.withValues(alpha: opacity);
  }

  TextStyle _navItemStyle(BuildContext context, String sectionKey) {
    final bool isSelected = widget.selectedSection == sectionKey;
    return isSelected
        ? context.navItemSelectedTextStyle
        : context.navItemTextStyle;
  }

  Color _getTextColor() {
    return scrollOffset < 200 ? kPrimary : kWhite;
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = context.isDesktop ? _getTextColor() : kWhite;

    return AppBar(
      elevation: 0,
      backgroundColor: context.isDesktop ? _getAppBarColor(context) : kPrimary,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(
          left: context.isMobile ? s38.w : s42.w,
          right: context.isMobile ? s0.w : s42.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thant Zin',
              style: context.navTitleTextStyle.copyWith(
                color: textColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            Spacer(),
            if (context.isMobile)
              IconButton(
                icon: Icon(Icons.menu, color: textColor),
                onPressed: widget.toggleNavDrawer,
              )
            else ...<Widget>[
              TextButton(
                onPressed: () => widget.onNavItemClicked(kHome),
                child: Text(
                  context.localization.home,
                  style: _navItemStyle(
                    context,
                    kHome,
                  ).copyWith(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () => widget.onNavItemClicked(kAbout),
                child: Text(
                  context.localization.about,
                  style: _navItemStyle(
                    context,
                    kAbout,
                  ).copyWith(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () => widget.onNavItemClicked(kExperience),
                child: Text(
                  context.localization.work_experience,
                  style: _navItemStyle(
                    context,
                    kExperience,
                  ).copyWith(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () => widget.onNavItemClicked(kPortfolio),
                child: Text(
                  context.localization.portfolio,
                  style: _navItemStyle(
                    context,
                    kPortfolio,
                  ).copyWith(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () => widget.onNavItemClicked(kEducation),
                child: Text(
                  context.localization.education,
                  style: _navItemStyle(
                    context,
                    kEducation,
                  ).copyWith(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () => widget.onNavItemClicked(kSkill),
                child: Text(
                  context.localization.skill,
                  style: _navItemStyle(
                    context,
                    kSkill,
                  ).copyWith(color: textColor),
                ),
              ),
            ],
            SizedBox().horizontalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
