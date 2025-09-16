import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_sizes.dart';

class ShadowButton extends StatefulWidget {
  const ShadowButton({
    required this.label,
    super.key,
    this.icon,
    this.onPressed,
  });

  final String label;
  final Widget? icon;
  final VoidCallback? onPressed;

  @override
  State<ShadowButton> createState() => _ShadowButtonState();
}

class _ShadowButtonState extends State<ShadowButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final double _borderRadius = 50.0.r;
  final Color _backgroundColor = kIndigo;
  final double _verticalPadding = s16.h;
  final double _horizontalPadding = s12.w;
  final Duration _duration = duration1000;
  final Curve _curve = Curves.easeInOut;
  final double _waveLength = 6.0;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null;

    final Color textColor =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
            Brightness.dark
        ? kWhite
        : kBlack;

    final Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.icon != null)
          Padding(
            padding: EdgeInsets.only(right: s8.w),
            child: IconTheme(
              data: IconThemeData(color: textColor),
              child: widget.icon!,
            ),
          ),
        Text(
          widget.label,
          style: context.buttonTextStyle.copyWith(color: textColor),
        ),
      ],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedScale(
        scale: _isHovered ? 1.1 : 1.0,
        duration: duration300,
        child: GestureDetector(
          onTap: isEnabled ? widget.onPressed : null,
          child: AnimatedShadowButton(
            animation: _controller,
            curve: _curve,
            verticalPadding: _verticalPadding,
            horizontalPadding: _horizontalPadding,
            backgroundColor: _backgroundColor,
            borderRadius: _borderRadius,
            waveLength: _waveLength,
            child: buttonContent,
          ),
        ),
      ),
    );
  }
}

class AnimatedShadowButton extends StatelessWidget {
  const AnimatedShadowButton({
    required this.animation,
    required this.curve,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.borderRadius,
    required this.waveLength,
    required this.backgroundColor,
    required this.child,
    super.key,
  });

  final Animation<double> animation;
  final Curve curve;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final double waveLength;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    final Animation<double> shadowBlur = Tween<double>(
      begin: 4.0,
      end: 20.0,
    ).animate(curvedAnimation);

    final Animation<double> shadowSpread = Tween<double>(
      begin: 1.0,
      end: 6.0,
    ).animate(curvedAnimation);

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: backgroundColor.withValues(alpha: 0.6),
                blurRadius: shadowBlur.value,
                spreadRadius: shadowSpread.value,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: child,
        );
      },
    );
  }
}
