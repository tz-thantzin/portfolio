import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/configs/configs.dart';
import '../../../core/di/providers.dart';
import '../../../utils/extensions/extensions.dart';

class SocialBanner extends ConsumerWidget {
  const SocialBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactList = contacts();

    // Slide in from left
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -100, end: 0),
      duration: duration1000,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(offset: Offset(value, 0), child: child);
      },
      child: Container(
        margin: EdgeInsets.only(left: context.autoAdaptive(s24)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.autoAdaptive(s32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.autoAdaptive(s8),
                vertical: context.autoAdaptive(s16),
              ),
              decoration: BoxDecoration(
                color: kWhite.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(context.autoAdaptive(s32)),
                border: Border.all(color: kWhite.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: kBlack.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(contactList.length, (index) {
                  return _SocialIcon(
                    iconData: contactList[index].icon,
                    onTap: () => ref
                        .read(homeViewModelProvider)
                        .onLaunchUrl(contactList[index].link),
                    isLast: index == contactList.length - 1,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final bool isLast;

  const _SocialIcon({
    required this.iconData,
    required this.onTap,
    this.isLast = false,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isHovered ? 1.2 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: duration200,
          curve: Curves.easeOutBack,
          margin: EdgeInsets.only(
            bottom: widget.isLast ? 0 : context.autoAdaptive(12),
          ),
          padding: EdgeInsets.all(context.autoAdaptive(s10)),
          transform: Matrix4.diagonal3Values(scale, scale, 1.0),
          decoration: BoxDecoration(
            color: _isHovered ? kGrey800 : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.iconData,
            color: _isHovered ? kWhite : kGrey800,
            size: context.autoAdaptive(s20),
          ),
        ),
      ),
    );
  }
}
