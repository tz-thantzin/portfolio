import 'package:flutter/material.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constants.dart';
import '../../../presentations/configs/duration.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.selectedSection,
    required this.onNavItemClicked,
    required this.onMenuTap,
    required this.controller,
    this.hasSideTitle = false,
  });

  final String selectedSection;
  final Function(String) onNavItemClicked;
  final VoidCallback onMenuTap;
  final AnimationController controller;
  final bool hasSideTitle;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return _mobileNavBar(context);
    } else {
      return _webNavBar(context);
    }
  }

  /// Mobile Navbar (Logo + Menu Icon)
  Widget _mobileNavBar(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.appBarHeight,
      color: kPrimary,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(24),
        vertical: context.autoAdaptive(12),
      ),
      child: Row(
        children: [
          Text(
            context.localization.thantzin.toUpperCase(),
            style: context.bodyLarge.copyWith(
              color: kWhite,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onMenuTap,
            child: Icon(
              Icons.menu,
              size: context.autoAdaptive(26),
              color: kWhite,
            ),
          ),
        ],
      ),
    );
  }

  /// Desktop Navbar (Logo + Nav Items)
  Widget _webNavBar(BuildContext context) {
    final navItems = [
      [context.localization.home, kHome],
      [context.localization.about, kAbout],
      [context.localization.work_experience, kExperience],
      [context.localization.portfolio, kPortfolio],
      [context.localization.skill, kSkill],
      [context.localization.contact, kContact],
    ];

    return Container(
      width: context.screenWidth,
      height: context.appBarHeight,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(42),
        vertical: context.autoAdaptive(16),
      ),
      child: Row(
        children: [
          Text(
            context.localization.thantzin.toUpperCase(),
            style: context.bodyLarge.copyWith(
              color: kBlack,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          ...navItems.map((item) {
            final String label = item[0];
            final String route = item[1];
            final bool isSelected = route == selectedSection;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _NavItem(
                label: label,
                isSelected: isSelected,
                onTap: () => onNavItemClicked(route),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = widget.isSelected ? kBlack : kGrey800;
    final Color hoverColor = widget.isSelected ? kBlack : kIndigo;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: duration200,
          style: context.bodyMedium.copyWith(
            color: _isHovered ? hoverColor : baseColor,
            fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w400,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
