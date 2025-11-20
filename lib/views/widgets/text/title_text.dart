import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';

class TitleText extends StatelessWidget {
  final String data;
  final double fontSize;
  final TextAlign? textAlign;
  TitleText(this.data, {this.fontSize = s24, this.textAlign, super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      data.toUpperCase(),

      style: GoogleFonts.roboto(
        textStyle: context.titleLarge.copyWith(
          fontSize: context.autoAdaptive(fontSize),
          fontWeight: bold,
          color: kBlack,
        ),
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
