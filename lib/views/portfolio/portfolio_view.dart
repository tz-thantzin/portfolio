import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/portfolio/project_card.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../widgets/text/title_text.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  final List<LinearGradient> _kGradients = [
    kTomatoGradient,
    kAmberGradient,
    kOrangeGradient,
  ];

  @override
  Widget build(BuildContext context) {
    final projectList = projects();

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      color: kPrimary,
      padding: EdgeInsets.symmetric(vertical: s40.h, horizontal: s24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TitleText(context.localization.portfolio),
          SizedBox().verticalSpaceMassive,
          ...List<Widget>.generate(projectList.length, (int i) {
            final gradient = _kGradients[i % _kGradients.length];
            final direction = i % 2 == 0 ? Direction.right : Direction.left;

            return Padding(
              padding: EdgeInsets.only(bottom: s38.h),
              child: ProjectCard(
                projectList[i],
                gradient: gradient,
                direction: direction,
              ),
            );
          }),
        ],
      ),
    );
  }
}
