import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../utils/event_analytics.dart';
import '../utils/utils.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isDrawerOpen = false;

  bool get isDrawerOpen => _isDrawerOpen;
  void initState() {
    AnalyticsService().logAppOpen();
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

  void onDownloadResumeBtnPressed() {
    AnalyticsService().sentEvent(eventName: EventType.downloadResume);
    launchUrlExternal(kMyCV);
  }

  void onProjectView(String path) {
    AnalyticsService().sentEvent(
      eventName: EventType.projectView,
      parameters: <String, Object>{'path': path},
    );

    launchUrlExternal(path);
  }

  void onLaunchUrl(String url) {
    launchUrlExternal(url);
  }
}
