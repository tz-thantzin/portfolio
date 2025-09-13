import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        if (drawLineBelow)
          Expanded(
            child: Container(
              width: 1.w,
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}
