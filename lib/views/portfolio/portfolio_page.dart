import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/portfolio/work_list_view.dart';
import 'package:portfolio/views/wrapper.dart';

import '../../route/routes.dart';
import '../footer/footer_view.dart';
import '../widgets/header_view.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
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
      selectedRoute: RoutePaths.portfolio,
      selectedPageName: RouteName.portfolio,
      child: Column(
        children: [
          HeaderView(
            title: context.localization.portfolio,
            onTapScrollDown: _onTapScrollDown,
          ),
          verticalSpaceMassive,
          WorkListView(),
          FooterView(),
        ],
      ).addScrollView(controller: _scrollController),
    );
  }
}
