import 'package:flutter/material.dart';

import '../../../presentations/configs/constant_colors.dart';
import '../../../presentations/configs/constants.dart';
import '../../../presentations/configs/duration.dart';
import '../../../utils/extensions/context_ex.dart';
import '../../../utils/extensions/layout_adapter_ex.dart';
import '../../../utils/extensions/theme_ex.dart';
import '../../../utils/extensions/widget_ex.dart';

class MenuView extends StatefulWidget {
  final Function(String) onNavItemClicked;
  final VoidCallback onCloseDrawer;

  const MenuView({
    required this.onNavItemClicked,
    required this.onCloseDrawer,
    super.key,
  });

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _itemCount = 6;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration800)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      [context.localization.home, kHome],
      [context.localization.about, kAbout],
      [context.localization.work_experience, kExperience],
      [context.localization.portfolio, kPortfolio],
      [context.localization.skill, kSkill],
      [context.localization.contact, kContact],
    ];

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: widget.onCloseDrawer,
          child: Container(color: kTransparent),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: kPrimary),
          margin: EdgeInsets.only(top: context.appBarHeight),
          padding: EdgeInsets.symmetric(
            vertical: context.autoAdaptive(16),
            horizontal: context.autoAdaptive(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(items.length, (index) {
              final intervalStart = (index / _itemCount).clamp(0.0, 1.0);
              final intervalEnd = ((index + 1) / _itemCount).clamp(0.0, 1.0);

              final animation = CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  intervalStart,
                  intervalEnd,
                  curve: Curves.easeOut,
                ),
              );

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.8, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: _navItem(context, items[index][0], items[index][1]),
                ),
              );
            }),
          ).addScrollView(),
        ),
      ],
    );
  }

  Widget _navItem(BuildContext context, String title, String route) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(8),
        vertical: context.autoAdaptive(4),
      ),
      title: Text(title, style: context.bodySmall.copyWith(color: kWhite)),
      onTap: () => widget.onNavItemClicked(route),
    );
  }
}
