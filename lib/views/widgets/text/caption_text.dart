import 'package:flutter/material.dart';

import '../../../utils/style_theme.dart';

class CaptionText extends StatelessWidget {
  final String data;
  const CaptionText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(data, style: AppTextStyle.captionTextStyle(context));
  }
}
