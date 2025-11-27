import 'package:flutter/material.dart';

import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';
import 'app_text.dart';

class HeadlineText extends AppText {
  const HeadlineText(
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
      FontSize.large => context.headlineLarge.copyWith(
        fontSize: context.autoAdaptive(s100),
      ),
      FontSize.medium => context.headlineMedium.copyWith(
        fontSize: context.autoAdaptive(s80),
      ),
      _ => context.headlineSmall.copyWith(fontSize: context.autoAdaptive(s64)),
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
