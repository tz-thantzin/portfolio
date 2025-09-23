import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/footer/footer_view.dart';
import 'package:portfolio/views/skill/language_tools.dart';
import 'package:portfolio/views/skill/work_flows.dart';

import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../route/routes.dart';
import '../widgets/header_view.dart';
import '../wrapper.dart';

class SkillsView extends StatefulWidget {
  const SkillsView({super.key});

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView> {
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
      selectedRoute: RoutePaths.skills,
      selectedPageName: RouteName.skills,
      child: Column(
        children: [
          HeaderView(
            title: context.localization.skill,
            onTapScrollDown: _onTapScrollDown,
          ),
          verticalSpaceMassive,
          LanguageAndTools(),
          verticalSpaceMassive,
          WorkFlows(),
          FooterView(),
        ],
      ).addScrollView(controller: _scrollController),
    );
  }
}
