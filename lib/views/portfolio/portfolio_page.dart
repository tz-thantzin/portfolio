import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../core/routing/routes.dart';
import '../../utils/extensions/extensions.dart';
import '../../views/portfolio/project_list_view.dart';
import '../../views/wrapper.dart';
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
            bgImagePath: kPortfolioBgImg,
          ),
          verticalSpaceMassive,
          ProjectListView(),
          FooterView(),
        ],
      ).addScrollView(controller: _scrollController),
    );
  }
}
