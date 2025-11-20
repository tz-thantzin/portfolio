import 'package:flutter/material.dart';

import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/extensions/theme_ex.dart';

class ContentText extends StatelessWidget {
  final String data;
  final Color? textColor;
  final double fontSize;
  const ContentText(
    this.data, {
    this.textColor,
    this.fontSize = s16,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      data,
      style: context.bodyMedium.copyWith(color: textColor, fontSize: fontSize),
    );
  }
}
