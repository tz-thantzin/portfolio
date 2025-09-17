import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/constants.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/tag_text.dart';
import '../widgets/text/title_text.dart';

class TechnologyGrid extends StatelessWidget {
  TechnologyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleText(context.localization.technologies),
          SizedBox().verticalSpaceMedium,
          Wrap(
            spacing: s2.w,
            runSpacing: s8.h,
            children: technologies.map((String tech) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: s4.w, vertical: s8.h),
                decoration: BoxDecoration(
                  color: kGrey100,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: kIndigo, width: s03.w),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: kGrey200.withValues(alpha: 0.05),
                      blurRadius: s10.r,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.arrow_right, size: s20.r, color: kPrimary),
                    TagText(tech),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
