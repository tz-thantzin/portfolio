import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:layout/layout.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';

extension LayoutAdapter on BuildContext {
  double assignHeight(
    double fraction, {
    double additions = 0,
    double subs = 0,
  }) {
    return (screenHeight - (subs) + (additions)) * fraction;
  }

  //
  double assignWidth(double fraction, {double additions = 0, double subs = 0}) {
    return (screenWidth - (subs) + (additions)) * fraction;
  }

  T adaptive<T>(T xs, T lg, {T? sm, T? md, T? xl}) {
    return layout.value<T>(
      xs: xs,
      sm: sm ?? (md ?? xs),
      md: md ?? sm,
      lg: lg,
      xl: xl ?? lg,
    );
  }

  /// mobile < 650
  bool get isMobile => MediaQuery.of(this).size.width < 650;

  /// tablet >= 650
  bool get isTablet => MediaQuery.of(this).size.width >= 650;

  ///desktop >= 1100
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;

  double get appBarHeight => 60.h;
}
