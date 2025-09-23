import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/text/animated_header_text.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../widgets/animated_slide_widget.dart';

class HeaderView extends StatefulWidget {
  final String title;
  final VoidCallback onTapScrollDown;

  const HeaderView({
    super.key,
    required this.onTapScrollDown,
    required this.title,
  });

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _moreController;

  @override
  void initState() {
    super.initState();
    _moreController = AnimationController(vsync: this, duration: duration1000)
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Center text
        AnimatedHeaderText(
          text: widget.title,
        ).addSizedBox(height: context.screenHeight).addCenter(),

        Container(
          constraints: BoxConstraints(minHeight: context.screenHeight),
          padding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(s60),
            vertical: context.autoAdaptive(s50),
          ),
          alignment: Alignment.bottomCenter,
          child: AnimatedSlideWidget(
            controller: _moreController,
            direction: SlideDirection.upToDown,
            fade: false,
            child: GestureDetector(
              onTap: widget.onTapScrollDown,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: context.autoAdaptive(s36),
                color: kBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
