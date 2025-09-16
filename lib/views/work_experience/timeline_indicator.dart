import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          width: s16.w,
          height: s16.h,
          decoration: BoxDecoration(color: kBlue, shape: BoxShape.circle),
        ),
        if (drawLineBelow)
          Expanded(
            child: Container(
              width: s1.w,
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}
