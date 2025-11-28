import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/configs/configs.dart';
import '../../../utils/extensions/extensions.dart';
import '../../widgets/text/app_text.dart';
import '../../widgets/text/body_text.dart';
import '../../widgets/text/label_text.dart';
import 'nav_logo.dart';

/// Mobile View (Full-Screen Nav Drawer Style)
class NavDrawer extends StatefulWidget {
  final String currentRoute;
  final Function(String) onNavItemClicked;
  final VoidCallback onCloseDrawer;

  const NavDrawer({
    required this.currentRoute,
    required this.onNavItemClicked,
    required this.onCloseDrawer,
    super.key,
  });

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1000)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _reverseAnimationAndClose() async {
    await _controller.reverse();
    widget.onCloseDrawer();
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

    late final int itemCount = items.length;

    return Scaffold(
      backgroundColor: kPrimary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(s42)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Close Button
            _buildCloseButton(context),

            verticalSpaceEnormous,

            /// Menu Items Section
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(items.length, (index) {
                  final intervalStart = (index / itemCount) * 0.7;
                  final intervalEnd = ((index + 1) / itemCount) * 0.7 + 0.3;

                  final animation = CurvedAnimation(
                    parent: _controller,
                    curve: Interval(
                      intervalStart.clamp(0.0, 1.0),
                      intervalEnd.clamp(0.0, 1.0),
                      curve: Curves.easeOutCubic,
                    ),
                  );

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-0.3, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: _navItem(
                        context,
                        items[index][0],
                        items[index][1],
                        index,
                      ),
                    ),
                  );
                }),
              ).addScrollView(),
            ),
            BodyText(
              context.localization.all_right_reserved,
              fontSize: FontSize.small,
              color: kGrey500,
              style: GoogleFonts.inter(),
              textAlign: TextAlign.center,
            ).addCenter(),

            verticalSpaceMedium,
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.appBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavLogo(
            onTap: () => widget.onNavItemClicked(kHome),
            title: context.localization.thantzin,
            currentRoute: widget.currentRoute,
            color: kWhite,
          ),
          GestureDetector(
            onTap: _reverseAnimationAndClose,
            child: Icon(
              Icons.close,
              color: kWhite,
              size: context.autoAdaptive(s26),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String title, String route, int index) {
    return InkWell(
      onTap: () {
        widget.onNavItemClicked(route);
        _reverseAnimationAndClose();
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.autoAdaptive(s14)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LabelText(
                '0${index + 1}.',
                fontWeight: medium,
                color: kWhite.withValues(alpha: 0.5),
              ).addPadding(
                padding: EdgeInsets.only(right: context.autoAdaptive(s16)),
              ),
              LabelText(
                title,
                fontSize: FontSize.medium,
                fontWeight: bold,
                color: kWhite,
                letterSpacing: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
