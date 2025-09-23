import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';

import '../../l10n/app_localizations.dart';
import '../../models/project.dart';
import '../../models/skill.dart';
import '../../models/social.dart';
import '../../models/work_experience.dart';
import 'constant_images.dart';

IconData _getIcon(String name) {
  switch (name.toLowerCase()) {
    case 'email':
      return Icons.email;
    case 'linkedin':
      return FontAwesomeIcons.linkedin;
    case 'facebook':
      return FontAwesomeIcons.facebook;
    case 'instagram':
      return FontAwesomeIcons.instagram;
    case 'github':
      return FontAwesomeIcons.github;
    default:
      return Icons.link;
  }
}

List<Social> contacts() {
  return <Social>[
    Social(
      name: 'Email',
      link: 'mailto:dev.thantzin@gmail.com',
      icon: _getIcon('Email'),
    ),
    Social(
      name: 'Github',
      link: 'https://github.com/tz-thantzin',
      icon: _getIcon('Github'),
    ),
    Social(
      name: 'LinkedIn',
      link: 'https://www.linkedin.com/in/thant-zin-9a855524/',
      icon: _getIcon('LinkedIn'),
    ),
    Social(
      name: 'Facebook',
      link: 'https://www.facebook.com/devthantzin/',
      icon: _getIcon('Facebook'),
    ),
    Social(
      name: 'Instagram',
      link: 'https://www.instagram.com/dev.thantzin/',
      icon: _getIcon('Instagram'),
    ),
  ];
}

List<Social> footerContacts() {
  return <Social>[
    Social(
      name: 'Email',
      link: 'mailto:dev.thantzin@gmail.com',
      icon: _getIcon('Email'),
    ),
    Social(
      name: 'Github',
      link: 'https://github.com/tz-thantzin',
      icon: _getIcon('Github'),
    ),
    Social(
      name: 'LinkedIn',
      link: 'https://www.linkedin.com/in/thant-zin-9a855524/',
      icon: _getIcon('LinkedIn'),
    ),
  ];
}

List<Project> recentProjects() {
  return <Project>[
    Project(
      projectName: 'My Animated Text',
      description:
          'Customizable Flutter animated text widgets for dynamic, engaging text effects.',
      imagePath: kAnimatedText,
      github: 'https://github.com/tz-thantzin/my_animated_text',
      pubDev: 'https://pub.dev/packages/my_animated_text',
    ),
    Project(
      projectName: 'Chat',
      description:
          'A Flutter-based chat application developed as a personal project to explore real-time messaging with Firebase.',
      imagePath: kChat,
      github: 'https://github.com/tz-thantzin/firebase_chat_flutter',
    ),
    Project(
      projectName: 'M-Ratex-Flutter',
      description:
          'A Flutter-based foreign currency application developed as a personal project.',
      imagePath: kMRate,
      github: 'https://github.com/tz-thantzin/myan_ratex',
    ),
    Project(
      projectName: 'M-Ratex-Swift',
      description:
          'A Swift-based foreign currency application developed as a personal project.',
      imagePath: kMRate,
      github: 'https://github.com/tz-thantzin/m-ratex-ios',
    ),
  ];
}

List<Project> projects() {
  return <Project>[
    Project(
      projectName: 'My Animated Text',
      description:
          'Customizable Flutter animated text widgets for dynamic, engaging text effects.',
      imagePath: kAnimatedText,
      github: 'https://github.com/tz-thantzin/my_animated_text',
      pubDev: 'https://pub.dev/packages/my_animated_text',
    ),
    Project(
      projectName: 'Chat',
      description:
          'A Flutter-based chat application developed as a personal project to explore real-time messaging with Firebase.',
      imagePath: kChat,
      github: 'https://github.com/tz-thantzin/firebase_chat_flutter',
    ),
    Project(
      projectName: 'Myflyn-SwiftUI',
      description:
          'Experimental iOS app built with SwiftUI to explore and practice modern development techniques.',
      imagePath: kMyf,
      github: 'https://github.com/tz-thantzin/my_flyn_ios_swiftui',
    ),
    Project(
      projectName: 'Myflyn-Flutter',
      description:
          'Experimental Android and iOS app built with flutter to explore and practice modern development techniques.',
      imagePath: kMyf,
      github: 'https://github.com/tz-thantzin/my_flyn',
    ),
    Project(
      projectName: 'M-Ratex-Flutter',
      description:
          'A Flutter-based foreign currency application developed as a personal project.',
      imagePath: kMRate,
      github: 'https://github.com/tz-thantzin/myan_ratex',
    ),
    Project(
      projectName: 'M-Ratex-Swift',
      description:
          'A Swift-based foreign currency application developed as a personal project.',
      imagePath: kMRate,
      github: 'https://github.com/tz-thantzin/m-ratex-ios',
    ),
  ];
}

List<Workflow> workflows(BuildContext context) {
  final AppLocalizations l10n = context.localization;

  return l10n.workflows
      .split('|')
      .map((String desc) => Workflow(description: desc.trim()))
      .toList();
}

List<Skill> languagesAndTools(BuildContext context) {
  return <Skill>[
    Skill(name: 'Flutter', iconPath: kFlutterSVG, percentage: 95),
    Skill(name: 'Dart', iconPath: kDartSVG, percentage: 99),
    Skill(name: 'Swift', iconPath: kSwiftSVG, percentage: 85),
    Skill(name: 'SwiftUI', iconPath: kSwiftUISVG, percentage: 75),
    Skill(name: 'Android', iconPath: kAndroidSVG, percentage: 60),
    Skill(name: 'Kotlin', iconPath: kKotlinSVG, percentage: 45),
    Skill(name: 'React', iconPath: kReactSVG, percentage: 65),
    Skill(name: 'Typescript', iconPath: kTypescriptSVG, percentage: 65),
    Skill(name: 'Firebase', iconPath: kFirebaseSVG, percentage: 90),
    Skill(name: 'AWS', iconPath: kAwsSVG, percentage: 60),
    Skill(name: 'SQLite', iconPath: kSQLiteSVG, percentage: 50),
    Skill(name: 'Postman', iconPath: kPostmanSVG, percentage: 80),
    Skill(name: 'Git', iconPath: kGitSVG, percentage: 90),
    Skill(name: 'Github', iconPath: kGithubSVG, percentage: 90),
    Skill(name: 'Fastlane', iconPath: kFastlaneSVG, percentage: 60),
    Skill(name: 'Android Studio', iconPath: kAndroidStudioSVG, percentage: 95),
    Skill(name: 'Xcode', iconPath: kXcodeSVG, percentage: 95),
    Skill(name: 'VSCode', iconPath: kVSCodeSVG, percentage: 70),
  ];
}

List<WorkExperience> experiences(BuildContext context) {
  final AppLocalizations l10n = context.localization;

  return <WorkExperience>[
    WorkExperience(
      title: l10n.freelance_title,
      period: l10n.freelance_period,
      company: l10n.freelance_company,
    ),
    WorkExperience(
      title: l10n.mobile_lead_title,
      period: l10n.mobile_lead_period,
      company: l10n.mobile_lead_company,
    ),
    WorkExperience(
      title: l10n.senior_dev_title,
      period: l10n.senior_dev_period,
      company: l10n.senior_dev_company,
    ),
    WorkExperience(
      title: l10n.mid_senior_dev_title,
      period: l10n.mid_senior_dev_period,
      company: l10n.mid_senior_dev_company,
    ),
    WorkExperience(
      title: l10n.research_leader_title,
      period: l10n.research_leader_period,
      company: l10n.research_leader_company,
    ),
    WorkExperience(
      title: l10n.software_engineer_title,
      period: l10n.software_engineer_period,
      company: l10n.software_engineer_company,
    ),
  ];
}
