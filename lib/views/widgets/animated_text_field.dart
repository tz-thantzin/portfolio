import 'package:flutter/material.dart';

import '../../../core/configs/configs.dart';
import '../../utils/extensions/extensions.dart';

class AnimatedUnderlineTextField extends StatefulWidget {
  final String? hintText;
  final bool isEmail;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Color underlineColor;
  final bool isMultiline;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;

  const AnimatedUnderlineTextField({
    super.key,
    this.hintText,
    this.isEmail = false,
    this.controller,
    this.focusNode,
    this.validator,
    this.underlineColor = kTomato,
    this.isMultiline = false,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  State<AnimatedUnderlineTextField> createState() =>
      _AnimatedUnderlineTextFieldState();
}

class _AnimatedUnderlineTextFieldState extends State<AnimatedUnderlineTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late FocusNode _focusNode;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();

    _controller = AnimationController(vsync: this, duration: duration500);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _controller.forward();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.reverse();
        _validate();
        if (widget.onEditingComplete != null) widget.onEditingComplete!();
      });
    }
  }

  void _validate() {
    if (widget.validator != null) {
      final result = widget.validator!(widget.controller?.text);
      setState(() {
        _errorMessage = result;
      });
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: widget.controller,
                keyboardType: widget.isEmail
                    ? TextInputType.emailAddress
                    : TextInputType.text,
                maxLines: widget.isMultiline ? null : 1,
                style: context.bodySmall.copyWith(
                  color: kPrimary,
                  fontSize: context.autoAdaptive(context.isMobile ? s16 : s13),
                  fontWeight: medium,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  hintStyle: context.bodySmall.copyWith(
                    color: kGrey500,
                    fontWeight: medium,
                    fontSize: context.autoAdaptive(
                      context.isMobile ? s16 : s13,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _validate();
                  if (widget.onChanged != null) widget.onChanged!(value);
                },
                onEditingComplete:
                    widget.onEditingComplete, // <-- trigger callback
              ),
            ),
            if (_errorMessage != null)
              Tooltip(
                message: _errorMessage!,
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ),
          ],
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double width = constraints.maxWidth * _animation.value;
                return Align(
                  alignment: _focusNode.hasFocus
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    height: 2,
                    width: width,
                    color: _errorMessage == null
                        ? widget.underlineColor
                        : Colors.red,
                  ),
                );
              },
            );
          },
        ).addSizedBox(height: context.autoAdaptive(s2)),
      ],
    );
  }
}
