import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web/web.dart' as web;

import '../../../view_models/home_view_model.dart';
import '../../presentations/configs/constants.dart';
import '../../presentations/configs/duration.dart';
import '../../presentations/configs/sizes.dart';
import '../../utils/extensions/context_ex.dart';
import '../views.dart';
import '../widgets/social_banner.dart';

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
      sectionName: Constants.home,
      child: const ProfileSection(),
    ),
    _SectionConfig(
      key: aboutKey,
      sectionName: Constants.about,
      child: const AboutSection(),
    ),
    _SectionConfig(
      key: experienceKey,
      sectionName: Constants.experience,
      child: const WorkExperienceSection(),
    ),
    _SectionConfig(
      key: educationKey,
      sectionName: Constants.education,
      child: const EducationSection(),
    ),
    _SectionConfig(
      key: skillKey,
      sectionName: Constants.skill,
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Consumer<HomeViewModel>(
          builder: (_, HomeViewModel homeViewModel, __) => NavBar(
            onNavItemClicked: homeViewModel.handleNavigation,
            toggleTheme: homeViewModel.toggleTheme,
            toggleNavDrawer: homeViewModel.toggleDrawer,
            themeMode: homeViewModel.themeMode,
            locale: homeViewModel.locale,
            setLocale: homeViewModel.setLocale,
            selectedSection: homeViewModel.currentSelectedSection,
          ),
        ),
      ),
      bottomNavigationBar: const FooterSection(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: s16.w),
            child: Column(
              children: List<Widget>.generate(
                _sections.length,
                (int index) => AnimatedSection(
                  key: ValueKey<String>('section_$index'),
                  sectionKey: _sections[index].key,
                  sectionName: _sections[index].sectionName,
                  index: index,
                  isVisible: _visibleList[index],
                  onVisible: () => setState(() => _visibleList[index] = true),
                  child: _sections[index].child,
                ),
              ),
            ),
          ),
          Container(width: 30.w, child: const SocialBanner()),
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

class AnimatedSection extends StatelessWidget {
  final Widget child;
  final Key sectionKey;
  final String sectionName;
  final int index;
  final bool isVisible;
  final VoidCallback onVisible;

  const AnimatedSection({
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
        if (info.visibleFraction > 0.75) {
          homeViewModel.updateCurrentSectionOnScroll(sectionName);
        }
      },
      child: Container(
        constraints: BoxConstraints(minHeight: context.sectionHeight),
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: duration2000,
          curve: Curves.easeOut,
          child: TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(begin: const Offset(0, 20), end: Offset.zero),
            duration: duration2000,
            curve: Curves.easeOut,
            builder: (BuildContext context, Offset offset, Widget? child) {
              return Transform.translate(
                key: sectionKey,
                offset: offset,
                child: child,
              );
            },
            child: child,
          ),
        ),
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
