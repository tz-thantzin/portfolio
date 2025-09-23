import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';

import '../../../utils/extensions/theme_ex.dart';

class TagText extends StatelessWidget {
  final String data;
  const TagText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      data,
      style: context.bodySmall.copyWith(color: kBlack),
    );
  }
}
