import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/extensions.dart';
import '../widgets/text/app_text.dart';
import '../widgets/text/body_text.dart';

class AboutDescription extends StatelessWidget {
  const AboutDescription();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.defaultPagePadding(),
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
