import 'package:flutter/material.dart';

import '../../../style_theme.dart';

class TagText extends StatelessWidget {
  final String data;
  const TagText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(data, style: AppTextStyle.tagTextStyle(context));
  }
}
