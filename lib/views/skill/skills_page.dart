import 'package:flutter/material.dart';
import '../../presentations/configs/constant_images.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../../views/footer/footer_view.dart';
import '../../views/skill/language_tools.dart';
import '../../views/skill/work_flows.dart';

import '../../core/routing/routes.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
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
