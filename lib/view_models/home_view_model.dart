import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import '../presentations/configs/constants.dart';
import '../presentations/configs/duration.dart';
import '../utils/event_analytics.dart';
import '../utils/utils.dart';

class HomeViewModel extends ChangeNotifier {
  late JSFunction _hashChangeListener;

  bool _isDrawerOpen = false;
  Timer? _debounceTimer;
  String _currentSelectedSection = '';

  bool _isNavigatingByClick = false;

  bool get isDrawerOpen => _isDrawerOpen;
  String get currentSelectedSection => _currentSelectedSection;

  @override
  void dispose() {
    removeHashChangeListener();
    super.dispose();
  }

  void cancelTimers() {
    _debounceTimer?.cancel();
  }

  void closeDrawer() {
    _isDrawerOpen = false;
    notifyListeners();
  }

  void toggleDrawer() {
    _isDrawerOpen = !_isDrawerOpen;
    notifyListeners();
  }

  void scrollToSection(GlobalKey key) {
    final BuildContext? context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: duration500,
        curve: Curves.easeInOut,
      );
    }
  }

  void handleNavigation(String section) {
    if (section.isEmpty || section == _currentSelectedSection) {
      return;
    }

    _isNavigatingByClick = true;
    _currentSelectedSection = section;
    notifyListeners();

    switch (section) {
      case kHome:
        updateBrowserUrl(kHome);
        scrollToSection(homeKey);
        break;
      case kAbout:
        updateBrowserUrl(kAbout);
        scrollToSection(aboutKey);
        break;
      case kExperience:
        updateBrowserUrl(kExperience);
        scrollToSection(experienceKey);
        break;
      case kPortfolio:
        updateBrowserUrl(kPortfolio);
        scrollToSection(portfolioKey);
        break;
      case kSkill:
        updateBrowserUrl(kSkill);
        scrollToSection(skillKey);
        break;
      case kContact:
        updateBrowserUrl(kContact);
        scrollToSection(contactKey);
        break;
      default:
        updateBrowserUrl(kHome);
        scrollToSection(homeKey);
        break;
    }

    Future<void>.delayed(duration800, () {
      _isNavigatingByClick = false;
    });
  }

  void updateCurrentSectionOnScroll(String section) {
    if (_isNavigatingByClick || section == _currentSelectedSection) {
      return;
    }

    _currentSelectedSection = section;
    updateBrowserUrl(section);
    notifyListeners();
  }

  Future<void> setupHashChangeListener() async {
    _hashChangeListener = ((web.Event event) {
      final String fragment = web.window.location.hash.replaceFirst('#', '');

      if (fragment.isEmpty || fragment == currentSelectedSection) {
        return;
      }

      _debounceTimer?.cancel();

      _debounceTimer = Timer(duration300, () {
        handleNavigation(fragment);
      });
    }).toJS;

    web.window.addEventListener('hashchange', _hashChangeListener);
  }

  void removeHashChangeListener() {
    cancelTimers();
    web.window.removeEventListener('hashchange', _hashChangeListener);
  }

  void onDownloadResumeBtnPressed() {
    EventAnalytics.sentEvent(
      eventName: EventType.downloadResume,
      parameters: <String, Object>{
        'timestamp': DateTime.now().toIso8601String(),
      },
    );

    launchUrlExternal(myCV);
  }

  void onProjectView(String path) {
    EventAnalytics.sentEvent(
      eventName: EventType.downloadResume,
      parameters: <String, Object>{
        'timestamp': DateTime.now().toIso8601String(),
        'path': path,
      },
    );

    launchUrlExternal(path);
  }

  void onContactMePressed(String url) {
    launchUrlExternal(url);
  }
}
