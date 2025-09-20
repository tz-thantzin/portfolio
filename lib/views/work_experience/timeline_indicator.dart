import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';

class TimeLineIndicator extends StatelessWidget {
  const TimeLineIndicator({required this.drawLineBelow});

  final bool drawLineBelow;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: context.autoAdaptive(s8),
          height: context.autoAdaptive(s8),
          decoration: BoxDecoration(color: kTomato, shape: BoxShape.circle),
        ),
        if (drawLineBelow)
          Container(
            width: context.autoAdaptive(s1),
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.6),
          ).addExpanded(),
      ],
    );
  }
}
