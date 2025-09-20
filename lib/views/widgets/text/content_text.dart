import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

import '../../../presentations/configs/constant_sizes.dart';

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
      style: context.bodyMedium.copyWith(
        color: textColor,
        fontSize: fontSize,
      ),
    );
  }
}
