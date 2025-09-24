import 'package:flutter/material.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../widgets/text/content_text.dart';
import '../widgets/text/title_text.dart';

class AboutDescription extends StatelessWidget {
  const AboutDescription();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(42),
        vertical: context.autoAdaptive(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleText(
            context.localization.little_bit_about_myself,
            fontSize: s16,
          ),
          verticalSpaceMedium,
          ContentText(context.localization.about_me_description),
        ],
      ),
    );
  }
}
