import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/configs/configs.dart';
import '../../core/di/providers.dart';
import '../../models/social.dart';
import '../../utils/extensions/extensions.dart';
import '../widgets/text/app_text.dart';
import '../widgets/text/body_text.dart';
import '../widgets/text/label_text.dart';

class FooterView extends ConsumerWidget {
  final bool isShowWorkTogether;
  const FooterView({super.key, this.isShowWorkTogether = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: context.defaultPagePadding(isFooter: true),
      decoration: BoxDecoration(
        color: kBlack100,
        border: Border(
          top: BorderSide(color: kWhite.withValues(alpha: s008)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isShowWorkTogether) ...[
            _AnimatedSection(
              delay: duration300,
              child: LabelText(
                context.localization.let_work_together,
                fontSize: FontSize.large,
                textAlign: TextAlign.center,
                fontWeight: bold,
                color: kWhite,
                style: GoogleFonts.syne(),
                letterSpacing: 5,
              ),
            ),
            verticalSpaceMedium,
            _AnimatedSection(
              delay: duration300,
              child: LabelText(
                context.localization.available_freelancing,
                fontSize: FontSize.medium,
                textAlign: TextAlign.center,
                fontWeight: medium,
                color: kWhite70,
                style: GoogleFonts.caveat(),
                letterSpacing: 5,
              ),
            ),
            verticalSpaceEnormous,
          ],

          _AnimatedSection(
            delay: isShowWorkTogether ? duration500 : duration300,
            child: _SocialMediaGlow(
              onSocialTap: (link) =>
                  ref.read(homeViewModelProvider).onLaunchUrl(link),
            ),
          ),

          verticalSpaceMassive,
          Divider(
            height: 1,
            thickness: 1,
            color: kGrey1000.withValues(alpha: s08),
            indent: context.autoAdaptive(s20),
            endIndent: context.autoAdaptive(s20),
          ),

          verticalSpaceMassive,
          _AnimatedSection(
            delay: isShowWorkTogether ? duration800 : duration300,
            child: Column(
              children: [
                BodyText(
                  context.localization.all_right_reserved,
                  fontSize: FontSize.small,
                  color: kGrey500,
                  style: GoogleFonts.inter(),
                ),
                verticalSpaceLarge,
                const _BuiltWithLove(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedSection extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedSection({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration1000,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
    ).animate(delay);
  }
}

class _SocialMediaGlow extends StatelessWidget {
  final void Function(String link) onSocialTap;
  const _SocialMediaGlow({required this.onSocialTap});

  @override
  Widget build(BuildContext context) {
    final List<Social> socialContacts = contacts();

    return Wrap(
      spacing: context.autoAdaptive(s32),
      runSpacing: context.autoAdaptive(s16),
      alignment: WrapAlignment.center,
      children: socialContacts.map((social) {
        return _SocialIconButton(social: social, onTap: onSocialTap);
      }).toList(),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final Social social;
  final void Function(String) onTap;

  const _SocialIconButton({required this.social, required this.onTap});

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  final ValueNotifier<bool> _isHovered = ValueNotifier(false);

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: GestureDetector(
        onTap: () => widget.onTap(widget.social.link),
        child: ValueListenableBuilder<bool>(
          valueListenable: _isHovered,
          builder: (context, hovered, _) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: hovered ? 1.3 : 1.0),
              duration: duration500,
              curve: Curves.easeOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    padding: const EdgeInsets.all(s16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kWhite.withValues(alpha: s005),
                      boxShadow: hovered
                          ? [
                              BoxShadow(
                                color: kWhite.withValues(alpha: s025),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      widget.social.icon,
                      color: Colors.white,
                      size: context.autoAdaptive(s20),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Pulsing heart "Built with love"
class _BuiltWithLove extends StatelessWidget {
  const _BuiltWithLove();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BodyText(
          context.localization.built_using,
          fontSize: FontSize.small,
          color: Colors.grey.shade500,
          style: GoogleFonts.inter(),
        ),
        horizontalSpaceSmall,
        FlutterLogo(size: context.autoAdaptive(s18)),
        horizontalSpaceSmall,
        BodyText(
          context.localization.built_with,
          fontSize: FontSize.small,
          color: Colors.grey.shade500,
          style: GoogleFonts.inter(),
        ),
        horizontalSpaceSmall,
        _PulsingHeart(),
      ],
    );
  }
}

class _PulsingHeart extends StatefulWidget {
  @override
  State<_PulsingHeart> createState() => _PulsingHeartState();
}

class _PulsingHeartState extends State<_PulsingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration1500)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale =
            1.0 + (0.2 * Curves.easeInOut.transform(_controller.value));
        return Transform.scale(
          scale: scale,
          child: Icon(
            FontAwesomeIcons.solidHeart,
            color: kTomato,
            size: context.autoAdaptive(s18),
          ),
        );
      },
    );
  }
}
