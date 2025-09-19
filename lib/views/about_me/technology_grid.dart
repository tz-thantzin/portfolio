import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/constants.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../widgets/text/tag_text.dart';
import '../widgets/text/title_text.dart';

class TechnologyGrid extends StatelessWidget {
  const TechnologyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(s8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleText(context.localization.technologies),
          SizedBox().verticalSpaceMedium,
          Wrap(
            spacing: context.autoAdaptive(s2),
            runSpacing: context.autoAdaptive(s8),
            children: technologies.map((String tech) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.autoAdaptive(s4),
                  vertical: context.autoAdaptive(s8),
                ),
                decoration: BoxDecoration(
                  color: kGrey100,
                  borderRadius: BorderRadius.circular(context.autoAdaptive(s4)),
                  border: Border.all(
                    color: kIndigo,
                    width: context.autoAdaptive(s03),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: kGrey200.withValues(alpha: 0.05),
                      blurRadius: context.autoAdaptive(s10),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_right,
                      size: context.autoAdaptive(s20),
                      color: kPrimary,
                    ),
                    TagText(tech),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
