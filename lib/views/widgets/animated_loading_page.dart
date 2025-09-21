import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/constant_colors.dart';
import 'package:portfolio/presentations/configs/constant_sizes.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/string_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';

/// credit to [https://davidcobbina.com]
class AnimatedLoadingPage extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback onLoadingDone;
  final Color? lineColor;

  const AnimatedLoadingPage({
    super.key,
    required this.text,
    this.style,
    required this.onLoadingDone,
    this.lineColor,
  });

  @override
  State<AnimatedLoadingPage> createState() => _AnimatedLoadingPageState();
}

class _AnimatedLoadingPageState extends State<AnimatedLoadingPage>
    with TickerProviderStateMixin {
  late final AnimationController _fadeOutController;
  late final AnimationController _containerController;
  late final AnimationController _scaleOpacityController;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _containerAnimation;

  final Duration _scaleDuration = const Duration(milliseconds: 750);
  final Duration _lineDuration = const Duration(milliseconds: 750);
  final Duration _containerDuration = const Duration(milliseconds: 2000);

  final double _lineHeight = 2;
  final Color _defaultLineColor = kGrey300.withValues(alpha: 0.35);

  bool _leftRightAnimationStarted = false;
  bool _leftRightAnimationDone = false;
  bool _isAnimationOver = false;

  late Size _textSize;
  late double _textWidth;
  late Color _lineColor;

  @override
  void initState() {
    super.initState();
    _setTextMetrics();
    _lineColor = widget.lineColor ?? _defaultLineColor;

    _initControllers();
    _initAnimations();
    _startAnimations();
  }

  void _initControllers() {
    _scaleOpacityController = AnimationController(
      vsync: this,
      duration: _scaleDuration,
    );
    _containerController = AnimationController(
      vsync: this,
      duration: _containerDuration,
    );
    _fadeOutController = AnimationController(
      vsync: this,
      duration: _lineDuration,
    );
  }

  void _initAnimations() {
    _scaleAnimation = Tween<double>(begin: 0.9, end: 0.5).animate(
      CurvedAnimation(
        parent: _scaleOpacityController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleOpacityController, curve: Curves.easeIn),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeIn),
    );
    _containerAnimation = Tween<double>(begin: 0, end: _textWidth).animate(
      CurvedAnimation(parent: _containerController, curve: Curves.ease),
    );
  }

  void _startAnimations() {
    _scaleOpacityController.forward();
    _scaleOpacityController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _containerController.forward();
      }
    });
    _containerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _leftRightAnimationStarted = true);
        _fadeOutController.forward();
      }
    });
    _fadeOutController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _leftRightAnimationDone = true);
      }
    });
  }

  void _setTextMetrics() {
    _textSize = widget.text.textSize(style: widget.style);
    _textWidth = _textSize.width;
  }

  @override
  void dispose() {
    _fadeOutController.dispose();
    _scaleOpacityController.dispose();
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setTextMetrics();
    final screenWidth = context.screenWidth;
    final screenHeight = context.screenHeight;

    final halfScreenHeight = screenHeight / 2;
    final leftLineWidth = context.assignWidth(0.5) - (_textWidth / 2);
    final rightLineWidth = screenWidth - (leftLineWidth + _textWidth);
    final leftContainerStart = (screenWidth / 2) - (_textWidth / 2);

    return _isAnimationOver
        ? const SizedBox.shrink()
        : <Widget>[
            _buildTopContainer(screenWidth, halfScreenHeight),
            _buildBottomContainer(screenWidth, halfScreenHeight),
            _buildCenterContent(
              context,
              screenWidth,
              leftLineWidth,
              rightLineWidth,
              leftContainerStart,
            ),
          ].addStack();
  }

  Widget _buildTopContainer(double screenWidth, double halfHeight) {
    return AnimatedContainer(
      width: screenWidth,
      height: _leftRightAnimationDone ? 0 : halfHeight,
      duration: _scaleDuration,
      color: kBlack,
      onEnd: () async {
        widget.onLoadingDone();
        setState(() => _isAnimationOver = true);
      },
    );
  }

  Widget _buildBottomContainer(double screenWidth, double halfHeight) {
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
        width: screenWidth,
        height: _leftRightAnimationDone ? 0 : halfHeight,
        duration: _scaleDuration,
        color: kBlack,
      ),
    );
  }

  Widget _buildCenterContent(
    BuildContext context,
    double screenWidth,
    double leftLineWidth,
    double rightLineWidth,
    double leftContainerStart,
  ) {
    return <Widget>[
          _buildAnimatedText(screenWidth),
          verticalSpaceMedium,
          _buildAnimatedLines(
            leftLineWidth,
            rightLineWidth,
            leftContainerStart,
          ),
        ]
        .addColumn(mainAxisAlignment: MainAxisAlignment.center)
        .addCenter()
        .addSizedBox(width: screenWidth);
  }

  Widget _buildAnimatedText(double screenWidth) {
    return SizedBox(
      width: screenWidth,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _scaleOpacityController,
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: widget.style,
          ),
          builder: (context, child) => Transform.scale(
            scale: 2 * _scaleAnimation.value,
            alignment: Alignment.center,
            child: AnimatedOpacity(
              opacity: _opacityAnimation.value,
              duration: _scaleDuration,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLines(
    double leftLineWidth,
    double rightLineWidth,
    double leftContainerStart,
  ) {
    return Row(
      children: [
        _buildLineSegment(
          width: leftLineWidth,
          rightAligned: false,
          blockWidth: leftContainerStart,
        ),
        _buildCenterLine(),
        _buildLineSegment(
          width: rightLineWidth,
          rightAligned: true,
          blockWidth: rightLineWidth,
        ),
      ],
    );
  }

  Widget _buildLineSegment({
    required double width,
    required bool rightAligned,
    required double blockWidth,
  }) {
    return SizedBox(
      width: width,
      child: <Widget>[
        Container(width: width, height: _lineHeight, color: _lineColor),
        Positioned(
          right: rightAligned ? 0 : null,
          child: AnimatedContainer(
            width: _leftRightAnimationStarted ? 0 : blockWidth,
            height: _lineHeight,
            color: kBlack,
            duration: _lineDuration,
          ),
        ),
      ].addStack(),
    );
  }

  Widget _buildCenterLine() {
    return AnimatedBuilder(
      animation: _containerController,
      builder: (context, child) => Container(
        height: _lineHeight,
        width: _containerAnimation.value,
        color: _lineColor,
      ),
    );
  }
}
