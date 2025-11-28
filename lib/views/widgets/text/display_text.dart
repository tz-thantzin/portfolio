import 'package:flutter/material.dart';

import '../../../core/configs/constant_sizes.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';
import 'app_text.dart';

class DisplayText extends AppText {
  const DisplayText(
    super.text, {
    super.key,
    super.fontSize = FontSize.medium,
    super.color,
    super.fontWeight,
    super.fontStyle,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.letterSpacing,
    super.height,
    super.decoration,
    super.softWrap = true,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = switch (fontSize) {
      FontSize.large => context.displayLarge.copyWith(
        fontSize: context.autoAdaptive(s96),
      ),
      FontSize.medium => context.displayLarge.copyWith(
        fontSize: context.autoAdaptive(s70),
      ),
      _ => context.displayLarge.copyWith(fontSize: context.autoAdaptive(s60)),
    };

    final TextStyle textStyle = getStyle(context, baseStyle).copyWith(
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
    );

    return Text(
      text,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: textStyle,
    );
  }
}
