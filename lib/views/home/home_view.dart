import 'package:flutter/material.dart';
import 'package:portfolio/views/portfolio/portfolio_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web/web.dart' as web;

import '../../../view_models/home_view_model.dart';
import '../../presentations/configs/constant_images.dart';
import '../../presentations/configs/constants.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../views.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  late List<bool> _visibleList;
  late HomeViewModel _homeViewModel;

  final List<_SectionConfig> _sections = <_SectionConfig>[
    _SectionConfig(
      key: homeKey,
      sectionName: kHome,
      child: const ProfileSection(),
    ),
    _SectionConfig(
      key: aboutKey,
      sectionName: kAbout,
      child: const AboutSection(),
    ),
    _SectionConfig(
      key: experienceKey,
      sectionName: kExperience,
      child: const WorkExperienceSection(),
    ),
    _SectionConfig(
      key: portfolioKey,
      sectionName: kPortfolio,
      child: const PortfolioView(),
    ),
    _SectionConfig(
      key: educationKey,
      sectionName: kEducation,
      child: const EducationSection(),
    ),
    _SectionConfig(
      key: skillKey,
      sectionName: kSkill,
      child: const SkillsSection(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _visibleList = List<bool>.filled(_sections.length, false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String hash = web.window.location.hash;
    final String section = hash.isNotEmpty ? hash.substring(1) : '';

    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (section.isNotEmpty) {
        _homeViewModel.handleNavigation(section);
      }
      _homeViewModel.setupHashChangeListener();
    });
  }

  @override
  void dispose() {
    _homeViewModel.removeHashChangeListener();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.appBarHeight),
        child: Consumer<HomeViewModel>(
          builder: (_, HomeViewModel homeViewModel, __) => NavBar(
            onNavItemClicked: homeViewModel.handleNavigation,
            toggleNavDrawer: homeViewModel.toggleDrawer,
            selectedSection: homeViewModel.currentSelectedSection,
            scrollController: _scrollController,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            kProfileBg,
            width: double.infinity,
            height: context.screenHeight,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ...List<Widget>.generate(
                  _sections.length,
                  (int index) => SectionWrapper(
                    key: ValueKey<String>('section_$index'),
                    sectionKey: _sections[index].key,
                    sectionName: _sections[index].sectionName,
                    index: index,
                    isVisible: _visibleList[index],
                    onVisible: () => setState(() => _visibleList[index] = true),
                    child: _sections[index].child,
                  ),
                ),
                const FooterSection(),
              ],
            ),
          ),
          Consumer<HomeViewModel>(
            builder: (_, HomeViewModel homeViewModel, __) => Visibility(
              visible: homeViewModel.isDrawerOpen,
              child: CustomNavigationDrawer(
                onCloseDrawer: homeViewModel.closeDrawer,
                onNavItemClicked: (String section) {
                  homeViewModel.closeDrawer();
                  homeViewModel.handleNavigation(section);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Key sectionKey;
  final String sectionName;
  final int index;
  final bool isVisible;
  final VoidCallback onVisible;

  const SectionWrapper({
    required this.child,
    required this.sectionKey,
    required this.sectionName,
    required this.index,
    required this.isVisible,
    required this.onVisible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Provider.of<HomeViewModel>(
      context,
      listen: false,
    );

    return VisibilityDetector(
      key: Key('section_visibility_$index'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          onVisible();
        }
        if (info.visibleFraction > 0.55) {
          homeViewModel.updateCurrentSectionOnScroll(sectionName);
        }
      },
      child: Container(
        key: sectionKey,
        constraints: BoxConstraints(minHeight: context.sectionHeight),
        child: child,
      ),
    );
  }
}

class _SectionConfig {
  final Key key;
  final String sectionName;
  final Widget child;
  const _SectionConfig({
    required this.key,
    required this.sectionName,
    required this.child,
  });
}
