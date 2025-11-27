import 'package:flutter/material.dart';

enum FontSize { small, medium, large }

abstract class AppText extends StatelessWidget {
  final String text;
  final FontSize fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;
  final bool softWrap;
  final TextStyle? style;

  const AppText(
    this.text, {
    super.key,
    this.fontSize = FontSize.medium,
    this.fontStyle,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.softWrap = true,
    this.style,
  });

  TextStyle getStyle(BuildContext context, TextStyle baseStyle) {
    TextStyle updatedTextStyle = baseStyle;

    // If user passed full custom style (e.g. GoogleFonts.playfairDisplay())
    if (style != null) {
      updatedTextStyle = updatedTextStyle.merge(style!);
    }

    return updatedTextStyle.copyWith(
      color: color ?? baseStyle.color,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError(
      'Use a specific text type like TitleText, BodyText, etc.',
    );
  }
}
