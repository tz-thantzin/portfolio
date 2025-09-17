import 'package:portfolio/models/project.dart';
import 'package:portfolio/presentations/configs/constant_images.dart';

List<Project> projects() {
  return <Project>[
    Project(
      projectName: 'My Animated Text',
      description:
          'A Flutter package that provides customizable animated text widgets, enabling dynamic and engaging text effects for apps.',
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
          'An experimental iOS app built with SwiftUI, developed as a personal project to test and practice modern iOS development techniques.',
      imagePath: kMyf,
      github: 'https://github.com/tz-thantzin/my_flyn_ios_swiftui',
    ),
  ];
}
