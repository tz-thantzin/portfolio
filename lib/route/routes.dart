import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/error_view.dart';
import '../views/home/home_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.home,
    routes: [
      _animatedRoute(RoutePaths.home, const HomeView(), name: RouteName.home),
      // Uncomment and add your other routes here
      // _animatedRoute(RoutePaths.about, const AboutView(), name: RouteName.about),
      // _animatedRoute(RoutePaths.experience, const WorkExperienceView(), name: RouteName.experience),
      // _animatedRoute(RoutePaths.portfolio, const PortfolioView(), name: RouteName.portfolio),
      // _animatedRoute(RoutePaths.skills, const SkillsView(), name: RouteName.skills),
      // _animatedRoute(RoutePaths.contact, const ContactView(), name: RouteName.contact),
    ],
    redirect: (context, state) {
      final uri = state.uri.toString();
      if (uri.startsWith('/#')) {
        return uri.replaceFirst('/#', '/'); // e.g. '/#about' → '/about'
      }
      return null;
    },
    errorBuilder: (context, state) => const ErrorView(),
  );

  // Helper to create routes with animated transitions
  static GoRoute _animatedRoute(String path, Widget page, {String? name}) {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation);

            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(opacity: fadeAnimation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      },
    );
  }
}

class RouteName {
  static const home = "home";
  static const about = "about";
  static const experience = "experience";
  static const portfolio = "portfolio";
  static const skills = "skills";
  static const contact = "contact";
}

class RoutePaths {
  static const home = "/";
  static const about = "/about";
  static const experience = "/experience";
  static const portfolio = "/portfolio";
  static const skills = "/skills";
  static const contact = "/contact";
}
