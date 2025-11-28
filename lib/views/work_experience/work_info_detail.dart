import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../models/work_experience.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../widgets/text/app_text.dart';
import '../widgets/text/body_text.dart';

class WorkInfoDetail extends StatelessWidget {
  final WorkExperience experience;

  const WorkInfoDetail({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 0 : context.autoAdaptive(s24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JobHeader(
            title: experience.title.toUpperCase(),
            period: experience.period,
          ),

          if (experience.company.isNotEmpty) ...[
            verticalSpaceTiny,
            BodyText(
              experience.company,
              fontSize: FontSize.small,
              color: kGrey1000,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          verticalSpaceTiny,
          BodyText(
            experience.workMode.label,
            fontSize: FontSize.small,
            color: kGrey500,
            fontStyle: FontStyle.italic,
          ),

          verticalSpaceMedium,

          if (experience.responsibilities case final responsibilities?
              when responsibilities.isNotEmpty)
            _ResponsibilitiesList(items: responsibilities),

          verticalSpaceMassive,
        ],
      ),
    );
  }
}

class _JobHeader extends StatelessWidget {
  final String title;
  final String period;

  const _JobHeader({required this.title, required this.period});

  @override
  Widget build(BuildContext context) {
    final titleWidget = BodyText(
      title,
      fontSize: FontSize.small,
      color: kBlack,
      fontWeight: bold,
    );

    final periodWidget = BodyText(
      period,
      fontSize: FontSize.small,
      color: kGrey1000,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    );

    return context.isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [titleWidget, periodWidget],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(child: titleWidget),
              horizontalSpaceSmall,
              periodWidget,
            ],
          );
  }
}

class _ResponsibilitiesList extends StatelessWidget {
  final List<String> items;

  const _ResponsibilitiesList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: context.autoAdaptive(s6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(
                    '• ',
                    fontSize: FontSize.small,
                    color: kGrey1000,
                    fontWeight: bold,
                  ),
                  Expanded(
                    child: BodyText(
                      item,
                      fontSize: FontSize.small,
                      color: kGrey1000,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

extension WorkModeX on WorkMode {
  String get label => switch (this) {
    WorkMode.remote => 'Remote',
    WorkMode.onsite => 'Onsite',
    WorkMode.hybrid => 'Hybrid',
  };
}
