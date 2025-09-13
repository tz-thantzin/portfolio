import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import '../models/skill.dart';
import '../utils/extensions/context_ex.dart';

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
