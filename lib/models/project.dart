import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String projectName;
  final String description;
  final String? imagePath;
  final String? github;
  final String? pubDev;

  const Project({
    required this.projectName,
    required this.description,
    this.imagePath,
    this.github,
    this.pubDev,
  });

  @override
  List<Object?> get props => [
    projectName,
    description,
    imagePath,
    github,
    pubDev,
  ];
}
