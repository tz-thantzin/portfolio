import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'utils/constants.dart';

bool _isDesktop(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  return width >= Constants.desktopSize;
}

double _scaleFontSize(BuildContext context, double base) {
  const double desktopScale = 1.25;
  return _isDesktop(context) ? base * desktopScale : base;
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
    color: AppColors.indigo,
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
    color: AppColors.white,
  );

  static TextStyle navDrawerTitleTextStyle(BuildContext context) => TextStyle(
    fontFamily: 'MulishLocal',
    fontFamilyFallback: _fallbackFonts,
    fontSize: _scaleFontSize(context, 16),
    color: AppColors.white,
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

class Paddings {
  static const int paddingXS = 4;
  static const int paddingS = 8;
  static const int paddingM = 16;
  static const int paddingL = 24;
  static const int paddingXL = 32;
  static const int paddingXXL = 40;
}

class Sizes {
  static const int sizeXS = 4;
  static const int sizeS = 8;
  static const int sizeM = 16;
  static const int sizeL = 24;
  static const int sizeXL = 32;
  static const int sizeXXL = 40;
}
