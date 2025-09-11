import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

import 'constants.dart';
import 'event_analytics.dart';

void updateBrowserUrl(String section) {
  if (web.window.location.hash.replaceFirst('#', '') != section) {
    final Uri newUri = Uri.base.replace(fragment: section);
    web.window.history.pushState(null, '', newUri.toString());
  }
}

Future<void> launchUrlExternal(String url) async {
  final Uri uri = Uri.parse(url);
  EventAnalytics.sentEvent(
    eventName: EventType.launchUrl,
    parameters: <String, Object>{
      'url': url,
      'timestamp': DateTime.now().toIso8601String(),
    },
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
