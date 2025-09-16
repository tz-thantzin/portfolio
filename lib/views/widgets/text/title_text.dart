import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';

import '../../../utils/extensions/theme_ex.dart';

class TitleText extends StatelessWidget {
  final String data;
  final Color? textColor;
  const TitleText(this.data, {this.textColor = kTomato, super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      data,
      style: context.titleTextStyle.copyWith(
        color: textColor,
        fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.center,
    );
  }
}
