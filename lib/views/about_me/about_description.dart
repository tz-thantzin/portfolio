import 'package:flutter/material.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../widgets/text/app_text.dart';
import '../widgets/text/body_text.dart';

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
          BodyText(
            context.localization.little_bit_about_myself,
            fontWeight: semiBold,
          ),
          verticalSpaceMedium,
          BodyText(
            context.localization.about_me_description,
            fontSize: FontSize.small,
            fontWeight: light,
            color: kBlack100,
          ),
        ],
      ),
    );
  }
}
