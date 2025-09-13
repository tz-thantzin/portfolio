import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presentations/configs/app_colors.dart';
import '../../../presentations/configs/duration.dart';
import '../../../presentations/configs/sizes.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/style_theme.dart';

class SnailLightButton extends StatefulWidget {
  final String label;
  final Widget? icon;
  final VoidCallback? onPressed;
  const SnailLightButton({
    required this.label,
    super.key,
    this.icon,
    this.onPressed,
  });

  @override
  State<SnailLightButton> createState() => _SnailLightButtonState();
}

class _SnailLightButtonState extends State<SnailLightButton>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller;

  BorderRadius get _radius => BorderRadius.circular(s24.r);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = AnimationController(vsync: this, duration: duration5000);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (TickerMode.of(context)) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_controller.isAnimating) {
      _controller.stop();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TickerMode(
      enabled: TickerMode.of(context),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: _radius,
              child: CustomPaint(
                foregroundPainter: _SnailBorderPainter(
                  progress: _controller.isAnimating ? _controller.value : 0.0,
                  borderRadius: _radius,
                  strokeWidth: 3,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[kPrimary, kSecondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: _radius,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? s8.w : s4.w,
                    vertical: context.isMobile ? s4.h : s8.h,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: widget.onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: _radius),
                    ),
                    icon: widget.icon,
                    label: Text(
                      widget.label,
                      style: AppTextStyle.buttonTextStyle(
                        context,
                      ).copyWith(color: kWhite, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SnailBorderPainter extends CustomPainter {
  final double progress;
  final BorderRadius borderRadius;
  final double strokeWidth;

  _SnailBorderPainter({
    required this.progress,
    required this.borderRadius,
    this.strokeWidth = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    final Rect rect = Offset.zero & size;
    final double deflateBy = strokeWidth / 2 + 0.5;

    final RRect rrect = RRect.fromRectAndCorners(
      rect.deflate(deflateBy),
      topLeft: Radius.circular(borderRadius.topLeft.x),
      topRight: Radius.circular(borderRadius.topRight.x),
      bottomLeft: Radius.circular(borderRadius.bottomLeft.x),
      bottomRight: Radius.circular(borderRadius.bottomRight.x),
    );

    final SweepGradient gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * math.pi,
      colors: <Color>[
        const Color(0x00FFFFFF),
        const Color(0xF2FFFFFF),
        const Color(0x00FFFFFF),
      ],
      stops: const <double>[0.0, 0.06, 0.12], // short bright segment
      transform: GradientRotation(progress * 2 * math.pi),
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _SnailBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
