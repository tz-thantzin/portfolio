import 'package:flutter/material.dart';

import '../../utils/extensions/layout_adapter_ex.dart';

class TitlePeriodView extends StatelessWidget {
  const TitlePeriodView({
    required this.title,
    required this.period,
    required this.titleStyle,
    required this.periodStyle,
  });

  final String title;
  final String period;
  final TextStyle titleStyle;
  final TextStyle periodStyle;

  @override
  Widget build(BuildContext context) {
    final TextHeightBehavior textHeightBehavior = const TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
    );

    final Text titleText = Text(
      title,
      style: titleStyle,
      textHeightBehavior: textHeightBehavior,
      overflow: TextOverflow.ellipsis,
    );

    final Text periodText = Text(
      period,
      style: periodStyle,
      overflow: TextOverflow.ellipsis,
      textHeightBehavior: textHeightBehavior,
      softWrap: false,
    );

    if (context.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[titleText, periodText],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(child: titleText),
        periodText,
      ],
    );
  }
}
