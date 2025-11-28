import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/extensions.dart';
import 'animated_slide_widget.dart';
import 'animated_text_button.dart';
import 'text/animated_header_text.dart';

class HeaderView extends StatefulWidget {
  final String title;
  final String? bgImagePath;

  final VoidCallback onTapScrollDown;

  const HeaderView({
    super.key,
    required this.onTapScrollDown,
    required this.title,
    this.bgImagePath,
  });

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _moreController;

  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration3000);
    _moreController = AnimationController(vsync: this, duration: duration1000)
      ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    Future.delayed(duration500, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _moreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Center text
        AnimatedHeaderText(
          text: widget.title,
        ).addSizedBox(height: context.screenHeight).addCenter(),

        if (widget.bgImagePath != null && widget.bgImagePath!.isNotEmpty)
          Positioned(
            bottom: context.autoAdaptive(-s16),
            right: context.autoAdaptive(s10),
            child: ScaleTransition(
              scale: _animation,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(widget.bgImagePath!, fit: BoxFit.contain),
              ).addSizedBox(height: context.autoAdaptive(s350)),
            ),
          ),

        Positioned(
          right: context.autoAdaptive(s16),
          bottom: context.autoAdaptive(s16),
          child: AnimatedSlideWidget(
            controller: _moreController,
            direction: SlideDirection.upToDown,
            fade: false,
            child: GestureDetector(
              onTap: widget.onTapScrollDown,
              child: RotatedBox(
                quarterTurns: 1,
                child: AnimatedTextButton(
                  widget.title.toUpperCase(),
                  hoverColor: kGrey700,
                  textColor: kBlack,
                  onPressed: () {
                    widget.onTapScrollDown();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
