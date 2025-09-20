import 'package:flutter/material.dart';

class EventType {
  static const String downloadResume = 'download_resume';
  static const String projectView = 'project_view';
  static const String launchUrl = 'launch_url';
}

final GlobalKey<State<StatefulWidget>> homeKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> aboutKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> skillKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> experienceKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> portfolioKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> contactKey = GlobalKey();

final RegExp emailRegex = RegExp(
  r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
);

const String kHome = 'home';
const String kAbout = 'about';
const String kSkill = 'skill';
const String kExperience = 'experience';
const String kPortfolio = 'portfolio';
const String kContact = 'contact';
const String myCV =
    'https://drive.google.com/file/d/1vocF0dz_r7ZHgdnguebKDXjmNeu-2rPM/view?usp=sharing';

final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
  applyHeightToFirstAscent: false,
  applyHeightToLastDescent: false,
);

// Mock data: category -> list of technologies
final Map<String, List<String>> technologies = const {
  'Mobile Technologies': [
    'Flutter',
    'Dart',
    'iOS',
    'Swift',
    'SwiftUI',
    'Android',
    'Kotlin',
  ],
  'Web / Cloud / Design': [
    'React JS',
    'Typescript',
    'Firebase',
    'AWS',
    'Google APIs',
    'Figma',
    'SQL',
    'Git',
  ],
};
