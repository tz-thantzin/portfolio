import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension LayoutAdapter on BuildContext {
  /// mobile < 650
  bool get isMobile => MediaQuery.of(this).size.width < 650;

  /// tablet >= 650
  bool get isTablet => MediaQuery.of(this).size.width >= 650;

  ///desktop >= 1100
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;

  double get appBarHeight => 60.h;
}
