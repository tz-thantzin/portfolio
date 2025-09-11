import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../style_theme.dart';
import '../../utils/constants.dart';
import 'text/tag_text.dart';
import 'text/title_text.dart';

class TechnologyGrid extends StatelessWidget {
  TechnologyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.sizeS.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleText(AppLocalizations.of(context)!.technologies),
          SizedBox(height: Sizes.sizeM.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 8.h,
            children: technologies.map((String tech) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.sizeXS.w,
                  vertical: Sizes.sizeS.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: AppColors.indigo, width: 0.3.w),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.grey500.withValues(alpha: 0.05),
                      blurRadius: 3.r,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_right,
                      size: 20.r,
                      color: AppColors.indigo,
                    ),
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
