import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../l10n/app_localizations.dart';
import '../../models/project.dart';
import '../../models/skill.dart';
import '../../models/social.dart';
import '../../models/work_experience.dart';
import '../../utils/extensions/context_ex.dart';
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
    case 'medium':
      return FontAwesomeIcons.medium;
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
    Social(
      name: 'Medium',
      link: 'https://devthantzin.medium.com/',
      icon: _getIcon('Medium'),
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
      projectName: 'Toastify',
      description:
          'A customizable toast notification system for Flutter. Supports banners, snackbars, and advanced styling.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/my_toastify',
      language: Language.flutter,
    ),
    Project(
      projectName: 'MUI Typography',
      description:
          'A Flutter package providing typography features similar to React MUI Typography.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/mui_typography',
      language: Language.flutter,
    ),
    Project(
      projectName: 'Chat',
      description:
          'A Flutter-based chat application developed as a personal project to explore real-time messaging with Firebase.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/firebase_chat_flutter',
      language: Language.flutter,
    ),
    Project(
      projectName: 'Weather',
      description:
          'A Swift-based weather application developed as a personal project.',
      imagePath: kSwiftSVG,
      github: 'https://github.com/tz-thantzin/Weather-iOS',
      language: Language.iOS,
    ),
    Project(
      projectName: 'M-Ratex',
      description:
          'A Swift-based foreign currency application developed as a personal project.',
      imagePath: kSwiftSVG,
      github: 'https://github.com/tz-thantzin/m-ratex-ios',
      language: Language.iOS,
    ),
  ];
}

List<Project> projects() {
  return <Project>[
    Project(
      projectName: 'Toastify',
      description:
          'A customizable toast notification system for Flutter. Supports banners, snackbars, and advanced styling.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/my_toastify',
      language: Language.flutter,
    ),
    Project(
      projectName: 'MUI Typography',
      description:
          'A Flutter package providing typography features similar to React MUI Typography.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/mui_typography',
      language: Language.flutter,
    ),
    Project(
      projectName: 'My Animated Text',
      description:
          'Customizable Flutter animated text widgets for dynamic, engaging text effects.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/my_animated_text',
      language: Language.flutter,
    ),
    Project(
      projectName: 'Chat',
      description:
          'A Flutter-based chat application developed as a personal project to explore real-time messaging with Firebase.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/firebase_chat_flutter',
      language: Language.flutter,
    ),
    Project(
      projectName: 'Flutter Riverpod',
      description:
          'Experimental Android and iOS app built with flutter to explore and practice modern development techniques.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/my_flutter_riverpod',
      language: Language.flutter,
    ),
    Project(
      projectName: 'M-Ratex',
      description:
          'A Flutter-based foreign currency application developed as a personal project.',
      imagePath: kFlutterSVG,
      github: 'https://github.com/tz-thantzin/myan_ratex',
      language: Language.flutter,
    ),
    Project(
      projectName: 'M-Ratex',
      description:
          'A Swift-based foreign currency application developed as a personal project.',
      imagePath: kSwiftSVG,
      github: 'https://github.com/tz-thantzin/m-ratex-ios',
      language: Language.iOS,
    ),
    Project(
      projectName: 'Weather',
      description:
          'A Swift-based weather application developed as a personal project.',
      imagePath: kSwiftSVG,
      github: 'https://github.com/tz-thantzin/Weather-iOS',
      language: Language.iOS,
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

List<WorkExperience> experiences() {
  return <WorkExperience>[
    WorkExperience(
      title: "Freelance Mobile Application Developer",
      company: "",
      period: "Apr 2024 – Present",
      workMode: WorkMode.remote,
      responsibilities: [
        'Developed cross-platform mobile applications using Flutter for both Android and iOS devices.',
        'Collaborated closely with clients to gather requirements and define app features.',
        'Provided regular updates on project progress.',
        'Offered technical consulting to help clients choose the most appropriate architecture, tools, and best practices tailored to their unique needs.',
      ],
    ),
    WorkExperience(
      title: "Project Leader",
      company: "TechFun Myanmar Co., Ltd., Yangon",
      period: "Nov 2019 – Mar 2024",
      workMode: WorkMode.remote,
      responsibilities: [
        'Developed and managed project timelines in collaboration with stakeholders to ensure a clear understanding of requirements and expected deliverables.',
        'Designed, created, and launched mobile applications using Flutter, as well as web applications built with ReactJS and TypeScript.',
        'Compiled comprehensive project documentation, including technical specifications, user manuals, and release notes.',
        'Worked closely with cross-functional teams to optimize application performance and enhance user experience.',
      ],
    ),
    WorkExperience(
      title: "Senior Mobile Application Developer",
      company: "TechFun Myanmar Co., Ltd., Yangon",
      period: "Nov 2017 – Oct 2019",
      workMode: WorkMode.onsite,
      responsibilities: [
        'Designed, developed, and maintained top-notch mobile applications for iOS and Android platforms.',
        'Provided technical leadership and mentorship to team members, encouraging compliance with best practices and coding standards.',
        'Identified and quickly addressed intricate technical issues and bugs.',
        'Worked collaboratively with cross-functional teams, including UI/UX designers, product managers, and backend developers, to create cohesive and user-friendly applications.',
      ],
    ),
    WorkExperience(
      title: "Mid-Senior Mobile Application Developer",
      company: "TechFun Myanmar Co., Ltd., Yangon",
      period: "Apr 2016 – Oct 2017",
      workMode: WorkMode.onsite,
      responsibilities: [
        'Designed, built, and maintained top-notch mobile applications for Android.',
        'Crafted clean, efficient, and well-documented code in close collaboration with the project leader.',
        'Led debugging sessions to tackle technical issues and enhance application performance.',
        'Conducted thorough testing to ensure app reliability and user satisfaction.',
      ],
    ),
    WorkExperience(
      title: "Researching Leader",
      company: "Acroquest Myanmar Technology Co., Ltd., Yangon",
      period: "Oct 2015 – Dec 2015",
      workMode: WorkMode.onsite,
      responsibilities: [
        'Evaluated new tools, frameworks, and methodologies to pinpoint potential enhancements for mobile application projects.',
        'Designed, developed, and implemented mobile applications for both Android and iOS platforms.',
        'Conducted research to identify new business opportunities for development.',
        'Reviewed resumes and applications to create a shortlist of candidates for interviews.',
      ],
    ),
    WorkExperience(
      title: "Software Engineer",
      period: "Feb 2014 – Sep 2015",
      company: "Acroquest Myanmar Technology Co., Ltd., Yangon",
      workMode: WorkMode.onsite,
      responsibilities: [
        'Conducted research to uncover new business needs in app development.',
        'Actively contributed to web development through involvement in both UI design and server/database management.',
        'Designed and developed mobile applications for both Android and iOS platforms.',
        'Engaged in continuous learning to stay updated with the latest industry trends and technologies.',
      ],
    ),
  ];
}
