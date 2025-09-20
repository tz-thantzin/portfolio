import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';

import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/extensions/theme_ex.dart';

class TitleText extends StatelessWidget {
  final String data;
  final Color? textColor;
  final double fontSize;
  final TextAlign? textAlign;
  TitleText(
    this.data, {
    this.textColor = kTomato,
    this.fontSize = s24,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      data.toUpperCase(),
      style: context.titleLarge.copyWith(
        color: textColor,
        fontSize: context.autoAdaptive(fontSize),
        fontWeight: bold,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
