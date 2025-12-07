import 'package:url_launcher/url_launcher.dart';

import '../core/configs/constants.dart';
import 'event_analytics.dart';

Future<void> launchUrlExternal(String url) async {
  final Uri uri = Uri.parse(url);
  AnalyticsService().sentEvent(
    eventName: EventType.launchUrl,
    parameters: <String, Object>{'url': url},
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

String calculateWorkExperience(DateTime startDate) {
  final DateTime now = DateTime.now();

  int years = now.year - startDate.year;
  int months = now.month - startDate.month;

  if (months < 0) {
    years -= 1;
    months += 12;
  }

  if (months == 0) {
    return '$years';
  } else {
    return '$years+';
  }
}
