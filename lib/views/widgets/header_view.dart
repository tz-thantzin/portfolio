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
  late final AnimationController _scrollHintController;

  late final Animation<double> _imageScaleAnimation;
  late final Animation<Offset> _imageSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration3000);
    _scrollHintController = AnimationController(
      vsync: this,
      duration: duration1500,
    )..repeat(reverse: true);

    _imageScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _imageSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    Future.delayed(duration500, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollHintController.dispose();
    super.dispose();
  }

  Widget _buildImage(BuildContext context) {
    if (widget.bgImagePath == null || widget.bgImagePath!.isEmpty) {
      return const SizedBox.shrink();
    }
    return SlideTransition(
      position: _imageSlideAnimation,
      child: ScaleTransition(
        scale: _imageScaleAnimation,
        child:
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(widget.bgImagePath!, fit: BoxFit.contain),
            ).addSizedBox(
              height: context.autoAdaptive(context.isMobile ? s250 : s400),
            ),
      ),
    );
  }

  Widget _buildScrollHint(BuildContext context) {
    return AnimatedSlideWidget(
      controller: _scrollHintController,
      direction: SlideDirection.downToUp,
      start: 0.0,
      end: 0.5,
      child: GestureDetector(
        onTap: widget.onTapScrollDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: AnimatedTextButton(
                context.localization.scroll_down.toUpperCase(),
                hoverColor: kTomato,
                textColor: kBlack,
                onPressed: widget.onTapScrollDown,
                style: context.labelSmall.copyWith(
                  letterSpacing: 2.0,
                  fontWeight: bold,
                ),
                showLeading: false,
              ),
            ),
            verticalSpaceSmall,
            Container(
              width: s1,
              height: context.autoAdaptive(s20),
              color: kBlack,
            ),
          ],
        ),
      ),
    );
  }

  /// MOBILE VIEW
  Widget _buildMobileView(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.screenHeight),
      alignment: Alignment.center,
      padding: context.defaultPagePadding(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSpaceMassive,
          // Center Text
          AnimatedHeaderText(text: widget.title, controller: _controller),
          verticalSpaceMassive,
          // Image below text
          _buildImage(context),
          verticalSpaceMassive,
        ],
      ),
    );
  }

  /// DESKTOP VIEW
  Widget _buildDesktopView(BuildContext context) {
    return Stack(
      children: [
        // Center text
        AnimatedHeaderText(
          text: widget.title,
          controller: _controller,
        ).addSizedBox(height: context.screenHeight).addCenter(),

        // Background Image
        Positioned(
          bottom: 0,
          right: context.autoAdaptive(s16),
          child: _buildImage(context),
        ),

        // Scroll Down Button
        Positioned(
          right: context.autoAdaptive(s16),
          bottom: context.autoAdaptive(s16),
          child: _buildScrollHint(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? _buildMobileView(context)
        : _buildDesktopView(context);
  }
}
