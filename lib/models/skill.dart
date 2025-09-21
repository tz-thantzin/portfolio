class Skill {
  final String iconPath;
  final String name;
  final double percentage;

  const Skill({
    required this.iconPath,
    required this.name,
    this.percentage = 0,
  });
}

class Workflow {
  final String description;

  const Workflow({required this.description});
}
