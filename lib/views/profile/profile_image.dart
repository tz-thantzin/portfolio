import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presentations/configs/constants.dart';
import '../../utils/extensions/layout_adapter_ex.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final double? size = context.isMobile ? 250.h : 450.h;

    return SizedBox(
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(ImagePath.codingImagePath, fit: BoxFit.contain),
      ),
    );
  }
}
