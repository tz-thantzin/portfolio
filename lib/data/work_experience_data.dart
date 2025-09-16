import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import '../models/work_experience.dart';
import '../utils/extensions/context_ex.dart';

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
