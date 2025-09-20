import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_loading_page.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web/web.dart' as web;

import '../../../view_models/home_view_model.dart';
import '../../presentations/configs/constant_images.dart';
import '../../presentations/configs/constants.dart';
import '../../utils/extensions/context_ex.dart';
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
      child: const ProfileView(),
    ),
    _SectionConfig(
      key: aboutKey,
      sectionName: kAbout,
      child: const AboutView(),
    ),
    _SectionConfig(
      key: experienceKey,
      sectionName: kExperience,
      child: WorkExperienceView(),
    ),
    _SectionConfig(
      key: portfolioKey,
      sectionName: kPortfolio,
      child: const PortfolioView(),
    ),
    _SectionConfig(
      key: skillKey,
      sectionName: kSkill,
      child: const SkillsView(),
    ),
    _SectionConfig(
      key: contactKey,
      sectionName: kContact,
      child: const ContactView(),
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

      body: <Widget>[
        //Background Image
        Image.asset(
          kProfileBg,
          width: double.infinity,
          height: context.screenHeight,
          fit: BoxFit.cover,
        ),

        //Main Content
        <Widget>[
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
        ].addColumn().addSingleChildScrollView(controller: _scrollController),

        //Nav Drawer it will show when screen size is mobile
        Consumer<HomeViewModel>(
          builder: (_, HomeViewModel homeViewModel, _) => Visibility(
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

        //Nav Bar it will show when screen size is desktop
        Container(
          height: context.appBarHeight,
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Consumer<HomeViewModel>(
            builder: (_, HomeViewModel homeViewModel, _) => NavBar(
              onNavItemClicked: homeViewModel.handleNavigation,
              toggleNavDrawer: homeViewModel.toggleDrawer,
              selectedSection: homeViewModel.currentSelectedSection,
              scrollController: _scrollController,
            ),
          ),
        ),
        AnimatedLoadingPage(
          text: "Thant Zin",
          onLoadingDone: () {},
          lineColor: kGrey100,
          style: context.titleLarge.copyWith(color: kWhite),
        ),
      ].addStack(),
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
        width: double.infinity,
        constraints: BoxConstraints(minHeight: context.sectionHeight),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: kGrey500)),
        ),
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
