import 'package:flutter/material.dart';

import '../../views/widgets/text/app_text.dart';
import 'theme_ex.dart';

extension FontSizeExt on BuildContext {
  TextStyle headlineStyle(FontSize size) {
    switch (size) {
      case FontSize.small:
        return theme().textTheme.headlineSmall!;
      case FontSize.medium:
        return theme().textTheme.headlineMedium!;
      case FontSize.large:
        return theme().textTheme.headlineLarge!;
    }
  }

  TextStyle titleStyle(FontSize size) {
    switch (size) {
      case FontSize.small:
        return theme().textTheme.titleSmall!;
      case FontSize.medium:
        return theme().textTheme.titleMedium!;
      case FontSize.large:
        return theme().textTheme.titleLarge!;
    }
  }

  TextStyle bodyStyle(FontSize size) {
    switch (size) {
      case FontSize.small:
        return theme().textTheme.bodySmall!;
      case FontSize.medium:
        return theme().textTheme.bodyMedium!;
      case FontSize.large:
        return theme().textTheme.bodyLarge!;
    }
  }

  TextStyle selectLabel(FontSize size) {
    switch (size) {
      case FontSize.small:
        return theme().textTheme.labelSmall!;
      case FontSize.medium:
        return theme().textTheme.labelMedium!;
      case FontSize.large:
        return theme().textTheme.labelLarge!;
    }
  }
}
