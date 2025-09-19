import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';

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
          width: context.autoAdaptive(s16),
          height: context.autoAdaptive(s16),
          decoration: BoxDecoration(color: kBlue, shape: BoxShape.circle),
        ),
        if (drawLineBelow)
          Expanded(
            child: Container(
              width: context.autoAdaptive(s1),
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}
