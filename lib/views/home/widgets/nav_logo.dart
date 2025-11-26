import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constants.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/duration.dart';
import '../../../utils/extensions/theme_ex.dart';

class NavLogo extends StatefulWidget {
  final String title;
  final String currentRoute;
  final Color color;
  final VoidCallback onTap;

  const NavLogo({
    super.key,
    required this.title,
    required this.currentRoute,
    required this.color,
    required this.onTap,
  });

  @override
  State<NavLogo> createState() => _NavLogoState();
}

class _NavLogoState extends State<NavLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isHomeScreen = kHome == widget.currentRoute;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isHomeScreen
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isHomeScreen ? null : widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: duration200,
          style: context.bodyLarge.copyWith(
            color: _isHovered && !isHomeScreen ? kIndigo : widget.color,
            fontWeight: bold,
          ),
          child: Text(widget.title.toUpperCase()),
        ),
      ),
    );
  }
}
