import 'package:flutter/material.dart';

import '../../../core/configs/constant_sizes.dart';
import '../../../utils/extensions/extensions.dart';
import 'app_text.dart';

class BodyText extends AppText {
  const BodyText(
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
      FontSize.large => context.bodyLarge.copyWith(
        fontSize: context.autoAdaptive(s24),
      ),
      FontSize.medium => context.bodyMedium.copyWith(
        fontSize: context.autoAdaptive(s16),
      ),
      _ => context.bodySmall.copyWith(
        fontSize: context.autoAdaptive(context.isMobile ? s16 : s12),
      ),
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
