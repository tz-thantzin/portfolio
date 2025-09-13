import 'package:flutter/material.dart';

import '../../../utils/style_theme.dart';

class ContentText extends StatelessWidget {
  final String data;
  const ContentText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(data, style: AppTextStyle.contentTextStyle(context));
  }
}
