import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/style_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade900
          : Colors.grey.shade100,
      height: 60.h,
      alignment: Alignment.bottomCenter,
      child: Center(
        child: Text(
          '© Thant Zin. All rights reserved.',
          style: AppTextStyle.footerTextStyle(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
