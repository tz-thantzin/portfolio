import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/padding_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/animated_slide_widget.dart';
import '../widgets/text/app_text.dart';
import '../widgets/text/body_text.dart';

class TechnologyGrid extends StatelessWidget {
  final AnimationController animationController;
  const TechnologyGrid({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.defaultPagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(context.localization.technologies, fontWeight: bold),
          verticalSpaceMedium,
          BodyText(
            context.localization.my_tools,
            fontSize: FontSize.small,
            color: kBlack100,
          ),
          verticalSpaceMedium,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: technologies.entries.map((entry) {
              return <Widget>[
                    BodyText(
                      entry.key,
                      fontSize: FontSize.small,
                      fontWeight: semiBold,
                      color: kBlack100,
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
                        direction: SlideDirection.upToDown,
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
        Icon(
          Icons.arrow_right,
          size: context.autoAdaptive(16),
          color: kGrey800,
        ),
        SizedBox(width: context.autoAdaptive(4)),
        BodyText(technology, fontSize: FontSize.small, color: kBlack100),
      ],
    );
  }
}
