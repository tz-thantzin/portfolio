import 'package:flutter/material.dart';
import 'package:portfolio/views/widgets/text/app_text.dart';
import 'package:portfolio/views/widgets/text/body_text.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../presentations/configs/constants.dart';
import '../../../presentations/configs/duration.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';
import 'nav_logo.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.currentRoute,
    required this.onNavItemClicked,
    required this.onMenuTap,
    required this.controller,
    this.hasSideTitle = false,
  });

  final String currentRoute;
  final Function(String) onNavItemClicked;
  final VoidCallback onMenuTap;
  final AnimationController controller;
  final bool hasSideTitle;

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? _mobileNavBar(context) : _webNavBar(context);
  }

  Widget _mobileNavBar(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.appBarHeight,
      color: kPrimary,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s42),
        vertical: context.autoAdaptive(s12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavLogo(
            onTap: () => onNavItemClicked(kHome),
            title: context.localization.thantzin,
            currentRoute: currentRoute,
            color: kWhite,
          ),
          GestureDetector(
            onTap: onMenuTap,
            child: Icon(
              Icons.menu,
              color: kWhite,
              size: context.autoAdaptive(s26),
            ),
          ),
        ],
      ),
    );
  }

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
        horizontal: context.autoAdaptive(s42),
        vertical: context.autoAdaptive(s16),
      ),
      child: Row(
        children: [
          NavLogo(
            onTap: () => onNavItemClicked(kHome),
            title: context.localization.thantzin,
            currentRoute: currentRoute,
            color: kBlack,
          ),
          const Spacer(),
          ...navItems.map((item) {
            final String label = item[0];
            final String route = item[1];
            final bool isSelected = route == currentRoute;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: s12),
              child: NavItem(
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

class NavItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  final ValueNotifier<bool> _isHovered = ValueNotifier(false);

  NavItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color baseColor = isSelected ? kBlack : kGrey800;
    final Color hoverColor = isSelected ? kBlack : kIndigo;

    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: ValueListenableBuilder<bool>(
          valueListenable: _isHovered,
          builder: (context, isHovered, child) {
            return AnimatedDefaultTextStyle(
              duration: duration200,
              style: context.bodyLarge.copyWith(
                color: isHovered ? hoverColor : baseColor,
                fontWeight: isSelected ? bold : medium,
              ),
              child: BodyText(label, fontSize: FontSize.small),
            );
          },
        ),
      ),
    );
  }
}
