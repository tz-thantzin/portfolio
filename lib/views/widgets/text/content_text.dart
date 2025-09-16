import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

class ContentText extends StatelessWidget {
  final String data;
  const ContentText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(data, style: context.contentTextStyle);
  }
}
