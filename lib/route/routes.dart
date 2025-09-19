import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/views/about_me/about_view.dart';
import 'package:portfolio/views/contact/contact_view.dart';
import 'package:portfolio/views/skill/skills_view.dart';
import 'package:portfolio/views/work_experience/work_experiences_view.dart';

import '../views/error_view.dart';
import '../views/home/home_view.dart';
import '../views/portfolio/portfolio_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      _animatedRoute(RoutePaths.home, const HomeView()),
      _animatedRoute(RoutePaths.about, const AboutView()),
      _animatedRoute(RoutePaths.experience, const WorkExperienceView()),
      _animatedRoute(RoutePaths.portfolio, const PortfolioView()),
      _animatedRoute(RoutePaths.skills, const SkillsView()),
      _animatedRoute(RoutePaths.contact, const ContactView()),
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
  static GoRoute _animatedRoute(String path, Widget page) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide from right + fade in
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
  static const skills = "skill";
  static const contact = "contact";
}

class RoutePaths {
  static const home = "/";
  static const about = "/about";
  static const experience = "/experience";
  static const portfolio = "/portfolio";
  static const skills = "/skill";
  static const contact = "/contact";
}
