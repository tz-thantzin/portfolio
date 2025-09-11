import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';
import '../data/skills_data.dart';
import '../l10n/app_localizations.dart';
import '../models/skill.dart';
import '../style_theme.dart';
import '../utils/constants.dart';
import 'widgets/text/content_text.dart';
import 'widgets/text/title_text.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Paddings.paddingXXL.h,
        horizontal: Paddings.paddingL.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LanguageAndTools(),
          SizedBox(height: Sizes.sizeXXL.h),
          WorkFlows(),
        ],
      ),
    );
  }
}

class LanguageAndTools extends StatelessWidget {
  const LanguageAndTools({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < Constants.desktopSize;

    final List<Skill> skills = languagesAndTools(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.sizeXXL.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TitleText(AppLocalizations.of(context)!.programming_languages_tools),
          SizedBox(height: Sizes.sizeXL.h),
          Wrap(
            spacing: Sizes.sizeS.w,
            runSpacing: Sizes.sizeM.h,
            alignment: WrapAlignment.center,
            children: skills.map((Skill skill) {
              return _SkillItem(
                iconPath: skill.iconPath,
                name: skill.name,
                isMobile: isMobile,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillItem extends StatelessWidget {
  final String iconPath;
  final String name;
  final bool isMobile;

  const _SkillItem({
    required this.iconPath,
    required this.name,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: name,
      child: Container(
        width: 70.r,
        height: 70.r,
        padding: EdgeInsets.all(Sizes.sizeM.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Sizes.sizeS.r),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.grey100,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Image.asset(iconPath, fit: BoxFit.contain),
      ),
    );
  }
}

class WorkFlows extends StatelessWidget {
  const WorkFlows({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Workflow> items = workflows(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TitleText(AppLocalizations.of(context)!.workflows_title),
        SizedBox(height: Sizes.sizeXL.h),
        Column(
          children: items
              .map(
                (Workflow workflow) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.sizeS.h,
                    horizontal: Sizes.sizeXXL.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      SizedBox(width: Sizes.sizeS.w),
                      Expanded(child: ContentText(workflow.description)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
