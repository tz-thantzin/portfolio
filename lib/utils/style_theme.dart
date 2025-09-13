import 'package:flutter/material.dart';

import '../presentations/configs/app_colors.dart';
import 'extensions/layout_adapter_ex.dart';

double _scaleFontSize(BuildContext context, double base) {
  const double desktopScale = 1.25;
  return context.isDesktop ? base * desktopScale : base;
}

const List<String> _fallbackFonts = <String>['NotoSansJP', 'NotoSansThai'];

class AppTextStyle {
  static TextStyle navTitleTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.primary,
    fontSize: _scaleFontSize(context, 16),
  );

  static TextStyle navItemTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontWeight: FontWeight.w500,
    color: kPrimary,
    fontSize: _scaleFontSize(context, 11),
  );

  static TextStyle navItemSelectedTextStyle(BuildContext context) =>
      navItemTextStyle(context).copyWith(
        fontWeight: FontWeight.w900,
        color: Theme.of(context).colorScheme.primary,
      );

  static TextStyle headerTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'RobotoCondensedLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 32),
    color: Theme.of(context).colorScheme.primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subHeaderTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 20),
    color: Theme.of(context).colorScheme.onSurface,
    fontWeight: FontWeight.bold,
  );

  static TextStyle descriptionTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 14),
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
  );

  static TextStyle titleTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'BungeeLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 20),
    color: Theme.of(context).colorScheme.primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle contentTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 14),
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle captionTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 11),
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle tagTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 10),
    color: Theme.of(context).colorScheme.primary,
  );

  static TextStyle blockTitleStyle(BuildContext context) => TextStyle(
    fontFamily: 'BebasNeueLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 14),
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle blockSubTitleStyle(BuildContext context) => TextStyle(
    fontFamily: 'BebasNeueLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 12),
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle blockPeriodStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 10),
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
  );

  static TextStyle footerTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 9),
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
  );

  static TextStyle blockDescriptionStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 12),
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
  );

  static TextStyle buttonTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 14),
    color: kWhite,
  );

  static TextStyle navDrawerTitleTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 16),
    color: kWhite,
    fontWeight: FontWeight.w600,
  );

  static TextStyle navDrawerDescriptionTextStyle(BuildContext context) =>
      TextStyle(
        fontFamily: 'MulishLocal',
        fontFamilyFallback: _fallbackFonts,
        fontSize: _scaleFontSize(context, 14),
        color: Colors.white70,
      );
}
