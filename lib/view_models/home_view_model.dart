import 'package:flutter/material.dart';

import '../presentations/configs/constants.dart';
import '../presentations/configs/duration.dart';
import '../utils/event_analytics.dart';
import '../utils/utils.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isDrawerOpen = false;

  bool get isDrawerOpen => _isDrawerOpen;

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
