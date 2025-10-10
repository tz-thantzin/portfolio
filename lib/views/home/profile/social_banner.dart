import 'package:flutter/material.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:provider/provider.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constant_data.dart';
import '../../../presentations/configs/constant_sizes.dart';
import '../../../view_models/home_view_model.dart';

class SocialBanner extends StatefulWidget {
  const SocialBanner({super.key});

  @override
  State<SocialBanner> createState() => _SocialBannerState();
}

class _SocialBannerState extends State<SocialBanner>
    with TickerProviderStateMixin {
  late final List<AnimationController> _bgControllers;
  late final List<Animation<double>> _bgScaleAnimations;

  @override
  void initState() {
    super.initState();
    final contactList = contacts();

    _bgControllers = List.generate(
      contactList.length,
      (index) => AnimationController(vsync: this, duration: duration500),
    );

    _bgScaleAnimations = _bgControllers
        .map(
          (controller) => Tween<double>(begin: 0, end: 1.2).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          ),
        )
        .toList();

    _runSequentialBackgroundAnimation();
  }

  Future<void> _runSequentialBackgroundAnimation() async {
    if (!mounted) return;
    for (final controller in _bgControllers) {
      if (mounted) await controller.forward();
      await Future.delayed(duration200);
      if (mounted) await controller.reverse();
    }
    _runSequentialBackgroundAnimation();
  }

  @override
  void dispose() {
    for (final controller in _bgControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactList = contacts();

    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: context.autoAdaptive(s16)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.autoAdaptive(s6),
          vertical: context.autoAdaptive(s12),
        ),
        decoration: BoxDecoration(
          color: kGrey100,
          borderRadius: BorderRadius.circular(context.autoAdaptive(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(contactList.length, (i) {
            return <Widget>[
                  AnimatedBuilder(
                    animation: _bgScaleAnimations[i],
                    builder: (_, child) => Transform.scale(
                      scale: _bgScaleAnimations[i].value,
                      child: Container(
                        width: context.autoAdaptive(s24),
                        height: context.autoAdaptive(s24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kBlue.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    contactList[i].icon,
                    color: kGrey700,
                    size: context.autoAdaptive(s18),
                  ),
                ]
                .addStack(alignment: Alignment.center)
                .addSizedBox(
                  width: context.autoAdaptive(s24),
                  height: context.autoAdaptive(s24) * 1.1,
                )
                .addInkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => context.read<HomeViewModel>().onLaunchUrl(
                    contactList[i].link,
                  ),
                )
                .addPadding(
                  padding: EdgeInsets.only(
                    bottom: i == contactList.length - 1
                        ? 0
                        : context.autoAdaptive(8),
                  ),
                );
          }),
        ),
      ),
    );
  }
}
