import 'package:flutter/material.dart';

import '../../core/configs/constant_sizes.dart';
import 'layout_adapter_ex.dart';

extension PaddingEX on BuildContext {
  EdgeInsetsGeometry defaultPagePadding({bool isFooter = false}) =>
      EdgeInsets.symmetric(
        horizontal: autoAdaptive(s42),
        vertical: autoAdaptive(isFooter ? s42 : s16),
      );
}
