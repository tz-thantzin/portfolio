import 'package:shared_preferences/shared_preferences.dart';

import '../presentations/configs/constants.dart';

class SessionUtil {
  final SharedPreferences _prefs;

  SessionUtil({required SharedPreferences prefs}) : _prefs = prefs;

  String? getLocale() => _prefs.getString(PrefKey.locale);

  Future<void> saveLocale(String code) async {
    await _prefs.setString(PrefKey.locale, code);
  }

  String? getThemeMode() {
    return _prefs.getString(PrefKey.themeMode);
  }

  Future<void> saveThemeMode(String themeMode) async {
    await _prefs.setString(PrefKey.themeMode, themeMode);
  }
}
