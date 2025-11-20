import 'package:flutter/material.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../utils/extensions/theme_ex.dart';

class CaptionText extends StatelessWidget {
  final String data;
  final Color? textColor;
  const CaptionText(this.data, {this.textColor = kGrey1000, super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      data,
      style: context.caption.copyWith(color: textColor),
    );
  }
}
