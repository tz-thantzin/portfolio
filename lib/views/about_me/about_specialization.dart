import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/extensions.dart';
import '../../views/widgets/animated_slide_widget.dart';
import '../widgets/animated_fade_widget.dart';
import '../widgets/text/label_text.dart';
import 'about_image.dart';

class AboutSpecialization extends StatefulWidget {
  final VoidCallback onTapScrollDown;
  const AboutSpecialization({super.key, required this.onTapScrollDown});

  @override
  State<AboutSpecialization> createState() => _AboutSpecializationState();
}

class _AboutSpecializationState extends State<AboutSpecialization>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _moreController;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(vsync: this, duration: duration1000);
    _moreController = AnimationController(vsync: this, duration: duration1000)
      ..repeat(reverse: true);

    Future.delayed(duration1000, () {
      if (mounted) {
        _textController.forward();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _moreController.dispose();
    super.dispose();
  }

  Widget _specializationText(BuildContext context) {
    return AnimatedFadeWidget(
      controller: _textController,
      start: 0.0,
      end: 0.4,
      child: LabelText(
        context.localization.my_specialization,
        softWrap: true,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.start,
        style: GoogleFonts.roboto(),
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _specializationText(context),
        verticalSpaceMedium,
        AnimatedFadeWidget(
          controller: _textController,
          start: 0.4,
          end: 1.0,
          child: const AboutImage(),
        ),
      ],
    );
  }

  Widget _desktopView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: _specializationText(context)),
        AnimatedFadeWidget(
          controller: _textController,
          start: 0.4,
          end: 1.0,
          child: const AboutImage(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.screenHeight),
      padding: context.defaultPagePadding(),
      alignment: Alignment.center,
      child: Column(
        children: [
          context.isMobile ? _mobileView(context) : _desktopView(context),
          Center(
            child: AnimatedSlideWidget(
              controller: _moreController,
              direction: SlideDirection.upToDown,
              fade: false,
              beginOffset: 0,
              endOffset: 0.5,
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
      ),
    );
  }
}
