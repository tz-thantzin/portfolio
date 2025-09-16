import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';

class ViewProjectButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  const ViewProjectButton(this.title, {this.onPressed, super.key});

  @override
  State<ViewProjectButton> createState() => _ViewProjectButtonState();
}

class _ViewProjectButtonState extends State<ViewProjectButton> {
  bool _isButtonHovered = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: s150.w,
      height: s40.h,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isButtonHovered = true),
        onExit: (_) => setState(() => _isButtonHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.title,
                  style: context.buttonTextStyle.copyWith(
                    fontSize: 12.5,
                    color: _isButtonHovered ? kIndigo : Colors.white,
                  ),
                ),
                TextSpan(
                  text: '→',
                  style: context.buttonTextStyle.copyWith(
                    fontSize: 12.5,
                    color: _isButtonHovered ? kIndigo : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
