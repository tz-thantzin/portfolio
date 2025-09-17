import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentations/configs/constant_images.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../utils/extensions/layout_adapter_ex.dart';

class AboutImage extends StatelessWidget {
  const AboutImage({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop ? _DesktopView() : _MobileView();
  }
}

class _DesktopView extends StatefulWidget {
  const _DesktopView();

  @override
  State<_DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<_DesktopView> {
  bool _isFlutterHovered = false;
  bool _isSwiftHovered = false;
  bool _isFirebaseHovered = false;

  @override
  Widget build(BuildContext context) {
    final double size = s450.h;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: <Widget>[
          // Base image
          SizedBox(
            height: size,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(kAboutMeIcon, fit: BoxFit.contain),
            ),
          ),

          // Flutter Icon
          Positioned(
            top: s96.h,
            left: -20.w,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isFlutterHovered = true),
              onExit: (_) => setState(() => _isFlutterHovered = false),
              child: AnimatedScale(
                scale: _isFlutterHovered ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Image.asset(kFlutterIcon, width: s70.w, height: s70.h),
              ),
            ),
          ),

          // Swift Icon
          Positioned(
            top: s18.h,
            left: s48.w,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isSwiftHovered = true),
              onExit: (_) => setState(() => _isSwiftHovered = false),
              child: AnimatedScale(
                scale: _isSwiftHovered ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Image.asset(kSwiftIcon, width: s70.w, height: s70.h),
              ),
            ),
          ),

          // Firebase Icon
          Positioned(
            top: s300.h,
            left: s20.w,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isFirebaseHovered = true),
              onExit: (_) => setState(() => _isFirebaseHovered = false),
              child: AnimatedScale(
                scale: _isFirebaseHovered ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: Image.asset(kFirebaseIcon, width: s70.w, height: s70.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) {
    final double size = s250.h;
    return SizedBox(
      height: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(kAboutMeIcon, fit: BoxFit.contain),
      ),
    );
  }
}
