import 'package:flutter/material.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../utils/extensions/layout_adapter_ex.dart';

extension ThemeEx on BuildContext {
  double scaleFontSize(double base) {
    const double desktopScale = 1.25;
    return isDesktop ? base * desktopScale : base;
  }

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kPrimary,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      textSelectionTheme: textSelectionTheme,
      colorScheme: colorScheme,
      iconTheme: iconTheme,
      highlightColor: kTransparent,
      focusColor: kPrimary,
      inputDecorationTheme: inputDecorationTheme,
    );
  }

  AppBarTheme get appBarTheme {
    return AppBarTheme(
      backgroundColor: kTransparent,
      elevation: 0,
      toolbarHeight: 100,
      titleTextStyle: navTitleTextStyle,
      foregroundColor: kBlue,
    );
  }

  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme(
      filled: true,
      fillColor: kTransparent,
      alignLabelWithHint: true,
    );
  }

  TextTheme get textTheme {
    return TextTheme(
      displayLarge: headerTextStyle,
      displayMedium: subHeaderTextStyle,
      displaySmall: circlingTextStyle,
      headlineLarge: titleTextStyle,
      headlineMedium: contentTextStyle,
      headlineSmall: captionTextStyle,
      titleLarge: blockTitleStyle,
      titleMedium: blockSubTitleStyle,
      titleSmall: blockPeriodStyle,
      bodyLarge: descriptionTextStyle,
      bodyMedium: blockDescriptionStyle,
      bodySmall: footerTextStyle,
      labelLarge: buttonTextStyle,
    ).apply(bodyColor: kBlack, displayColor: kBlack);
  }

  TextSelectionThemeData get textSelectionTheme {
    return TextSelectionThemeData(
      cursorColor: kSecondary,
      selectionColor: kSecondary,
      selectionHandleColor: kSecondary,
    );
  }

  IconThemeData get iconTheme {
    return const IconThemeData(color: kBlack);
  }

  ColorScheme get colorScheme {
    return ColorScheme(
      brightness: Brightness.light,
      primary: kPrimary,
      onPrimary: kPrimary,
      secondary: kSecondary,
      onSecondary: kSecondary,
      error: kRed,
      onError: kRed100,
      surface: kGrey100,
      onSurface: kGrey100,
    );
  }

  /// ---------------- Text Styles ----------------

  TextStyle get navTitleTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontWeight: FontWeight.bold,
    color: kBlue,
    fontSize: scaleFontSize(16),
  );

  TextStyle get navItemTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontWeight: FontWeight.w500,
    color: kBlue,
    fontSize: scaleFontSize(11),
  );

  TextStyle get navItemSelectedTextStyle =>
      navItemTextStyle.copyWith(fontWeight: FontWeight.w900, color: kBlue);

  TextStyle get headerTextStyle => TextStyle(
    fontFamily: 'RobotoCondensedLocal',
    fontSize: scaleFontSize(32),
    color: colorScheme.primary,
    fontWeight: FontWeight.bold,
  );

  TextStyle get subHeaderTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(20),
    color: colorScheme.onSurface,
    fontWeight: FontWeight.bold,
  );

  TextStyle get circlingTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(14),
    color: colorScheme.primary,
    fontWeight: FontWeight.bold,
  );

  TextStyle get descriptionTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(14),
    color: colorScheme.onSurface.withValues(alpha: 0.6),
  );

  TextStyle get titleTextStyle => TextStyle(
    fontFamily: 'BungeeLocal',
    fontSize: scaleFontSize(20),
    color: kBlue,
    fontWeight: FontWeight.bold,
  );

  TextStyle get contentTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(14),
    color: colorScheme.onSurface,
  );

  TextStyle get captionTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(11),
    color: colorScheme.onSurface,
  );

  TextStyle get tagTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(10),
    color: colorScheme.primary,
  );

  TextStyle get blockTitleStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(14),
    fontWeight: FontWeight.w600,
    color: colorScheme.onSurface,
  );

  TextStyle get blockSubTitleStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(12),
    fontWeight: FontWeight.normal,
    color: colorScheme.onSurface,
  );

  TextStyle get blockPeriodStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(10),
    color: colorScheme.onSurface.withValues(alpha: 0.6),
  );

  TextStyle get footerTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(10),
    color: colorScheme.onSurface.withValues(alpha: 0.5),
  );

  TextStyle get blockDescriptionStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(12),
    color: colorScheme.onSurface.withValues(alpha: 0.6),
  );

  TextStyle get buttonTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(14),
    color: kWhite,
  );

  TextStyle get navDrawerTitleTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(16),
    color: kWhite,
    fontWeight: FontWeight.w600,
  );

  TextStyle get navDrawerDescriptionTextStyle => TextStyle(
    fontFamily: 'MulishLocal',
    fontSize: scaleFontSize(14),
    color: kWhite70,
  );
}
