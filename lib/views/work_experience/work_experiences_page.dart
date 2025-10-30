import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_images.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/header_view.dart';
import 'package:portfolio/views/work_experience/work_info_view.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../route/routes.dart';
import '../footer/footer_view.dart';
import '../wrapper.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  void _onTapScrollDown() {
    _scrollController.animateTo(
      context.screenHeight,
      duration: duration500,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      selectedRoute: RoutePaths.experience,
      selectedPageName: RouteName.experience,
      child: Column(
        children: [
          HeaderView(
            title: context.localization.work_experience,
            onTapScrollDown: _onTapScrollDown,
            bgImagePath: kExperienceBg,
          ),
          verticalSpaceMassive,
          WorkInfoView(),
          FooterView(),
        ],
      ).addScrollView(controller: _scrollController),
    );
  }
}
