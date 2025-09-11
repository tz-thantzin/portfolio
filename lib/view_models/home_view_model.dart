import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import '../utils/constants.dart';
import '../utils/event_analytics.dart';
import '../utils/session.dart';
import '../utils/utils.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required SessionUtil sessionUtil})
    : _sessionUtil = sessionUtil,
      super() {
    _loadLocale();
    _loadThemeMode();
  }

  late JSFunction _hashChangeListener;
  final SessionUtil _sessionUtil;

  ThemeMode _themeMode = ThemeMode.light;
  Locale? _locale;

  bool _isDrawerOpen = false;
  Timer? _debounceTimer;
  String currentSelectedSection = '';

  bool _isNavigatingByClick = false;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;

  bool get isDrawerOpen => _isDrawerOpen;

  @override
  void dispose() {
    removeHashChangeListener();
    super.dispose();
  }

  Future<void> _loadThemeMode() async {
    final String? theme = _sessionUtil.getThemeMode();
    _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    await _sessionUtil.saveThemeMode(
      _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }

  Future<void> _loadLocale() async {
    final String? savedLocale = _sessionUtil.getLocale();
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _sessionUtil.saveLocale(locale.languageCode);
    notifyListeners();
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
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void handleNavigation(String section) {
    if (section.isEmpty || section == currentSelectedSection) {
      return;
    }

    _isNavigatingByClick = true;
    currentSelectedSection = section;
    notifyListeners();

    switch (section) {
      case Constants.home:
        updateBrowserUrl(Constants.home);
        scrollToSection(homeKey);
        break;
      case Constants.about:
        updateBrowserUrl(Constants.about);
        scrollToSection(aboutKey);
        break;
      case Constants.experience:
        updateBrowserUrl(Constants.experience);
        scrollToSection(experienceKey);
        break;
      case Constants.education:
        updateBrowserUrl(Constants.education);
        scrollToSection(educationKey);
        break;
      case Constants.skill:
        updateBrowserUrl(Constants.skill);
        scrollToSection(skillKey);
        break;
      default:
        updateBrowserUrl(Constants.home);
        scrollToSection(homeKey);
        break;
    }

    Future<void>.delayed(const Duration(milliseconds: 800), () {
      _isNavigatingByClick = false;
    });
  }

  void updateCurrentSectionOnScroll(String section) {
    if (_isNavigatingByClick || section == currentSelectedSection) {
      return;
    }

    currentSelectedSection = section;
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

      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
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
      eventName: EventType.hireMe,
      parameters: <String, Object>{
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
    print(
      _locale?.languageCode == LanguageCode.ja.name
          ? Constants.myJpCV
          : Constants.myCV,
    );
    launchUrlExternal(
      _locale?.languageCode == LanguageCode.ja.name
          ? Constants.myJpCV
          : Constants.myCV,
    );
  }

  void onContactMePressed(String url) {
    launchUrlExternal(url);
  }
}
