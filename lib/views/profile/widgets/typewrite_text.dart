import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration speed;
  final Duration startDelay;
  final TextStyle? style;

  const TypewriterText(
    this.text, {
    super.key,
    this.style,
    this.speed = duration300,
    this.startDelay = duration2000,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = '';
  int _index = 0;
  bool _isRunning = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _resetAndRestartTyping();
    }
  }

  @override
  void dispose() {
    _isRunning = false;
    super.dispose();
  }

  void _resetAndRestartTyping() {
    _isRunning = false;
    setState(() {
      _displayText = '';
      _index = 0;
      _finished = false;
    });
    _startTyping();
  }

  Future<void> _startTyping() async {
    if (_isRunning) return;
    _isRunning = true;

    // Initial delay before typing starts
    await Future<void>.delayed(widget.startDelay);

    while (mounted && _isRunning && _index < widget.text.length) {
      await Future<void>.delayed(widget.speed);

      if (!mounted || !_isRunning) break;

      setState(() {
        _index++;
        _displayText = widget.text.substring(0, _index);
      });
    }

    if (mounted) {
      setState(() {
        _finished = true;
      });
    }

    _isRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _finished ? _displayText : '$_displayText|',
      style: widget.style,
    );
  }
}
