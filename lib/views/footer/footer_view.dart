import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/di/providers.dart';
import '../../models/social.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/theme_ex.dart';
import '../../utils/extensions/widget_ex.dart';

class FooterView extends ConsumerWidget {
  final bool isShowWorkTogether;
  const FooterView({super.key, this.isShowWorkTogether = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s42),
        vertical: context.autoAdaptive(s50),
      ),
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
              child: Text(
                context.localization.let_work_together,
                textAlign: TextAlign.center,
                style: GoogleFonts.syne(
                  fontSize: context.autoAdaptive(s50),
                  fontWeight: bold,
                  color: kWhite,
                ),
              ),
            ),
            verticalSpaceMedium,
            _AnimatedSection(
              delay: duration300,
              child: Text(
                context.localization.available_freelancing,
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                  fontSize: context.autoAdaptive(s32),
                  fontWeight: medium,
                  color: kWhite70,
                ),
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
                Text(
                  '© 2025 Thant Zin. All rights reserved.',
                  style: GoogleFonts.inter(
                    fontSize: context.autoAdaptive(s14),
                    color: kGrey500,
                  ),
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

class _SocialIconButtonState extends State<_SocialIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration500);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.social.link),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (_isHovered) {
              _controller.forward();
            } else {
              _controller.reverse();
            }

            return Transform.scale(
              scale: 1.0 + (_controller.value * 0.3),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kWhite.withValues(alpha: s005),
                  boxShadow: _isHovered
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
                  size: context.autoAdaptive(s25),
                ),
              ),
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
        Text(
          context.localization.built_using,
          style: GoogleFonts.inter(
            color: Colors.grey.shade500,
            fontSize: context.autoAdaptive(s14),
          ),
        ),
        horizontalSpaceSmall,
        FlutterLogo(size: context.autoAdaptive(s18)),
        horizontalSpaceSmall,
        Text(
          context.localization.built_with,
          style: GoogleFonts.inter(
            color: Colors.grey.shade500,
            fontSize: context.autoAdaptive(s14),
          ),
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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
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
