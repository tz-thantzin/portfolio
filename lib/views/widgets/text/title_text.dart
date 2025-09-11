import 'package:flutter/material.dart';

import '../../../style_theme.dart';

class TitleText extends StatelessWidget {
  final String data;
  const TitleText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      data,
      style: AppTextStyle.titleTextStyle(context),
      textAlign: TextAlign.center,
    );
  }
}
