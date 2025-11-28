import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../core/routing/routes.dart';
import '../../utils/extensions/extensions.dart';
import '../../views/footer/footer_view.dart';
import '../../views/skill/language_tools.dart';
import '../widgets/header_view.dart';
import '../wrapper.dart';
import 'work_flows.dart';

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
            bgImagePath: kSkillBg,
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
