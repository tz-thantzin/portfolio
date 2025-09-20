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
      projectName: 'Myflyn',
      description:
          'Experimental iOS app built with SwiftUI to explore and practice modern development techniques.',
      imagePath: kMyf,
      github: 'https://github.com/tz-thantzin/my_flyn_ios_swiftui',
    ),
    Project(
      projectName: 'M-Ratex Flutter',
      description:
          'A Flutter-based foreign currency application developed as a personal project.',
      imagePath: kMRate,
      github: 'https://github.com/tz-thantzin/myan_ratex',
    ),
    Project(
      projectName: 'M-Ratex Swift',
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
    Skill(name: 'Flutter', iconPath: 'assets/icons/flutter_icon.png'),
    Skill(name: 'React', iconPath: 'assets/icons/react.png'),
    Skill(name: 'Swift', iconPath: 'assets/icons/swift_icon.png'),
    Skill(name: 'SwiftUI', iconPath: 'assets/icons/swiftui.png'),
    Skill(name: 'Firebase', iconPath: 'assets/icons/firebase_icon.png'),
    Skill(name: 'AWS', iconPath: 'assets/icons/aws_icon.png'),
    Skill(name: 'MySQL', iconPath: 'assets/icons/mysql.png'),
    Skill(name: 'Postgresql', iconPath: 'assets/icons/postgresql.png'),
    Skill(name: 'Postman', iconPath: 'assets/icons/postman.png'),
    Skill(name: 'Git', iconPath: 'assets/icons/git.png'),
    Skill(name: 'Fastlane', iconPath: 'assets/icons/fastlane_icon.png'),
    Skill(
      name: 'Android Studio',
      iconPath: 'assets/icons/android_studio_icon.png',
    ),
    Skill(name: 'Xcode', iconPath: 'assets/icons/xcode_icon.png'),
    Skill(name: 'VSCode', iconPath: 'assets/icons/visual_studio_code_icon.png'),
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
