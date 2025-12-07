import 'package:equatable/equatable.dart';

enum Language { android, iOS, flutter }

class Project extends Equatable {
  final String projectName;
  final String description;
  final String? imagePath;
  final String? link;
  final Language language;

  const Project({
    required this.projectName,
    required this.description,
    this.imagePath,
    this.link,
    this.language = Language.flutter,
  });

  @override
  List<Object?> get props => [
    projectName,
    description,
    imagePath,
    link,
    language,
  ];
}
