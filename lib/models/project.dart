class Project {
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
}
