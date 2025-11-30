import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/extensions.dart';
import 'text/app_text.dart';
import 'text/body_text.dart';

class AnimatedTextButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color hoverColor;
  final Color textColor;
  final double fontSize;
  final bool isLoading;
  final TextStyle? style;
  final bool showLeading;

  const AnimatedTextButton(
    this.title, {
    this.onPressed,
    this.hoverColor = kIndigo,
    this.textColor = kWhite,
    this.isLoading = false,
    this.fontSize = s10,
    this.style,
    this.showLeading = true,
    super.key,
  });

  @override
  State<AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton>
    with SingleTickerProviderStateMixin {
  bool _isButtonHovered = false;
  late AnimationController _controller;
  late Animation<Offset> _arrowOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration300);

    _arrowOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.2, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool hover) {
    if (widget.showLeading) {
      setState(() => _isButtonHovered = hover);
      if (hover) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    } else {
      setState(() => _isButtonHovered = hover);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = _isButtonHovered
        ? widget.hoverColor
        : widget.textColor;

    final TextStyle effectiveStyle = (widget.style ?? context.labelLarge)
        .copyWith(
          fontSize: context.autoAdaptive(widget.fontSize),
          color: effectiveColor,
        );

    return SizedBox(
      height: context.autoAdaptive(s24),
      child: MouseRegion(
        key: const ValueKey('MouseRegion_Animated_Text_Button'),
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: GestureDetector(
          onTap: widget.isLoading ? null : widget.onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: context.autoAdaptive(s14),
                  height: context.autoAdaptive(s14),
                  child: SpinKitWanderingCubes(color: kIndigo, size: 16.0),
                )
              else ...[
                AnimatedDefaultTextStyle(
                  duration: duration300,
                  curve: Curves.easeInOut,
                  style: effectiveStyle,
                  child: BodyText(
                    widget.title,
                    style: effectiveStyle,
                    fontSize: FontSize.small,
                  ),
                ),
                if (widget.showLeading) ...[
                  horizontalSpaceTiny,
                  SlideTransition(
                    position: _arrowOffset,
                    child: SvgPicture.asset(
                      kRightArrowSVG,
                      height: context.autoAdaptive(s14),
                      width: context.autoAdaptive(s14),
                      colorFilter: ColorFilter.mode(
                        effectiveColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
