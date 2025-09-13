import 'package:flutter/material.dart';

final GlobalKey<State<StatefulWidget>> homeKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> aboutKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> skillKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> educationKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> experienceKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> contactKey = GlobalKey();

class Constants {
  static const String home = 'home';
  static const String about = 'about';
  static const String skill = 'skill';
  static const String education = 'education';
  static const String experience = 'experience';
  static const String myCV =
      'https://github.com/tz-thantzin/portfolio/blob/main/assets/pdf/ThantZin_CV.pdf';
  static const String myJpCV =
      'https://github.com/tz-thantzin/portfolio/blob/main/assets/pdf/ThantZin_JP_CV.pdf';
}

class EventType {
  static const String hireMe = 'hire_me';
  static const String launchUrl = 'launch_url';
}

class PrefKey {
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
}

class ImagePath {
  static const String codingImagePath = 'assets/images/home.png';
  static const String codingGIFPath = 'assets/images/coding.gif';
  static const String aboutMeImagePath = 'assets/images/about_me.png';
}

final List<String> technologies = <String>[
  'Flutter (Dart)',
  'Android (Java, Kotlin)',
  'iOS (Swift, SwiftUI)',
  'Unity (C#)',
  'React',
  'TypeScript',
  'BLoC',
  'GetX',
  'Provider',
  'Riverpod',
  'Localization',
  'MVVM',
  'MVC',
  'Responsive UI',
  'REST API',
  'Firebase',
  'AWS',
  'Google APIs',
  'Git / Version Control',
  'Third‑Party SDKs',
  'SQLite',
  '2C2P Payment',
];

enum LanguageCode { en, ja, th }
