import 'package:firebase_analytics/firebase_analytics.dart';

class EventAnalytics {
  static Future<void> sentEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
