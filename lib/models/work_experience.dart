enum WorkMode { remote, onsite, hybrid }

class WorkExperience {
  final String title;
  final String period;
  final String company;
  final WorkMode workMode;
  final List<String>? responsibilities;

  const WorkExperience({
    required this.title,
    required this.period,
    required this.company,
    required this.workMode,
    this.responsibilities,
  });
}
