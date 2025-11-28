import 'package:flutter/material.dart';

class EventType {
  static const String downloadResume = 'download_resume';
  static const String projectView = 'project_view';
  static const String launchUrl = 'launch_url';
}

final GlobalKey<State<StatefulWidget>> homeKey = GlobalKey();
final GlobalKey<State<StatefulWidget>> recentProjectKey = GlobalKey();

final RegExp emailRegex = RegExp(
  r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
);

const String kHome = 'home';
const String kRecentProject = 'recentProject';
const String kAbout = 'about';
const String kSkill = 'skills';
const String kExperience = 'experience';
const String kPortfolio = 'portfolio';
const String kContact = 'contact';

const String kMyCV =
    'https://drive.google.com/file/d/1vocF0dz_r7ZHgdnguebKDXjmNeu-2rPM/view?usp=sharing';

const String kGithubRepo = 'https://github.com/tz-thantzin?tab=repositories';

final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
  applyHeightToFirstAscent: false,
  applyHeightToLastDescent: false,
);

final Map<String, List<String>> technologies = const {
  'Mobile Technologies': [
    'Flutter',
    'Dart',
    'iOS',
    'Swift',
    'SwiftUI',
    'Android',
    'Java',
    'Kotlin',
    'Unity',
  ],
  'Web & Other Technologies': [
    'React JS',
    'Typescript',
    'Python',
    'Firebase',
    'AWS',
    'Google APIs',
    'Figma',
    'SQL',
    'Git',
  ],
};
