import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/content_text.dart';
import '../widgets/text/title_text.dart';

class AboutMessages extends StatelessWidget {
  const AboutMessages();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s24.w),
      child: Column(
        crossAxisAlignment: context.isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleText(context.localization.i_am_developer),
          SizedBox().verticalSpaceMedium,
          ContentText(context.localization.about_me_description),
        ],
      ),
    );
  }
}
