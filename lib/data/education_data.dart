import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/education.dart';
import '../utils/extensions/context_ex.dart';

List<Education> educations(BuildContext context) {
  final AppLocalizations l10n = context.localization;

  return <Education>[
    Education(
      degree: l10n.education1_degree,
      duration: l10n.education1_duration,
      institution: l10n.education1_institution,
    ),
    Education(
      degree: l10n.education2_degree,
      duration: l10n.education2_duration,
      institution: l10n.education2_institution,
    ),
    Education(
      degree: l10n.education3_degree,
      duration: l10n.education3_duration,
      institution: l10n.education3_institution,
    ),
  ];
}
