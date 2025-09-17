import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';

class HoverSlideButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final Color hoverColor;
  final Color textColor;
  final IconData iconData;
  final bool hasIcon;
  final bool isLoading;
  final double width;
  final double height;
  final Duration duration;

  const HoverSlideButton({
    super.key,
    required this.title,
    this.onPressed,
    this.buttonColor = kBlack,
    this.hoverColor = kTomato,
    this.textColor = kWhite,
    this.iconData = Icons.send,
    this.hasIcon = true,
    this.isLoading = false,
    this.width = 180,
    this.height = 50,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<HoverSlideButton> createState() => _HoverSlideButtonState();
}

class _HoverSlideButtonState extends State<HoverSlideButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    if (widget.onPressed == null) return;
    if (hovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.buttonColor,
          ),
          child: Stack(
            children: [
              // Sliding hover overlay
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: widget.width * _animation.value,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.hoverColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),

              // Text & icon
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.hasIcon) ...[
                      const SizedBox(width: 8),
                      widget.isLoading
                          ? SpinKitWanderingCubes(
                              color: widget.textColor,
                              size: 16,
                            )
                          : Icon(
                              widget.iconData,
                              color: widget.textColor,
                              size: 18,
                            ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
