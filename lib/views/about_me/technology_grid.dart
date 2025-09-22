import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';
import 'package:portfolio/presentations/configs/constants.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../../presentations/configs/constant_colors.dart';
import '../widgets/animated_slide_widget.dart';
import '../widgets/text/tag_text.dart';
import '../widgets/text/title_text.dart';

class TechnologyGrid extends StatelessWidget {
  final AnimationController animationController;
  const TechnologyGrid({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(context.localization.technologies),
          verticalSpaceMedium,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: technologies.entries.map((entry) {
              return <Widget>[
                    Text(
                      entry.key,
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      ),
                    ),
                    verticalSpaceSmall,
                    ...entry.value.asMap().entries.map((techEntry) {
                      final int index = techEntry.key; // stagger index
                      final tech = techEntry.value;

                      final count = entry.value.length;
                      final double step = 1.0 / (count + 1);

                      final double slideStart = step * index;
                      final double slideEnd = (slideStart + step).clamp(
                        0.0,
                        1.0,
                      );

                      return AnimatedSlideWidget(
                        controller: animationController,
                        start: slideStart,
                        end: slideEnd,
                        direction: SlideDirection.down,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.autoAdaptive(4),
                          ),
                          child: TechnologyItem(technology: tech),
                        ),
                      );
                    }),
                  ]
                  .addColumn(crossAxisAlignment: CrossAxisAlignment.start)
                  .addPadding(
                    padding: EdgeInsets.only(right: context.autoAdaptive(s24)),
                  )
                  .addExpanded();
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TechnologyItem extends StatelessWidget {
  final String technology;
  const TechnologyItem({required this.technology, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_right, size: context.autoAdaptive(16), color: kWhite),
        SizedBox(width: context.autoAdaptive(4)),
        TagText(technology),
      ],
    );
  }
}
