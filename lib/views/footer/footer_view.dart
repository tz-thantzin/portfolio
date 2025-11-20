// lib/views/footer/footer_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/di/providers.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_scale_widget.dart';
import 'package:portfolio/views/widgets/text/animated_fade_in_text.dart';

import '../../models/social.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';

class FooterView extends ConsumerWidget {
  final bool isShowWorkTogether;
  const FooterView({super.key, this.isShowWorkTogether = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Social> contactList = contacts();

    return Container(
      color: kFooterBg,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s24),
        vertical: context.autoAdaptive(s16),
      ),
      child:
          [
            if (isShowWorkTogether) ...[
              AnimatedFadeInText(
                context.localization.let_work_together,
                style: GoogleFonts.poorStory(
                  textStyle: context.titleLarge.copyWith(
                    color: kWhite,
                    fontSize: context.autoAdaptive(s48),
                  ),
                ),
                delay: duration1000,
              ),
              verticalSpaceSmall,
              AnimatedFadeInText(
                context.localization.available_freelancing,
                style: GoogleFonts.caveat(
                  textStyle: context.bodySmall.copyWith(
                    color: kWhite70,
                    fontSize: context.autoAdaptive(s24),
                  ),
                ),
                delay: duration1000,
              ),
            ],
            verticalSpaceLarge,
            _SocialMedia(
              contactList: contactList,
              onSocialTap: (link) =>
                  ref.read(homeViewModelProvider).onLaunchUrl(link),
            ),
            verticalSpaceLarge,
            Text(
              '© 2025 Thant Zin. All rights reserved.',
              style: context.bodySmall.copyWith(color: kGrey300),
              textAlign: TextAlign.center,
            ),
            verticalSpaceMedium,
            const _BuiltWith(),
            verticalSpaceLarge,
          ].addColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
    );
  }
}

class _BuiltWith extends StatelessWidget {
  const _BuiltWith();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.localization.built_using,
          style: context.bodySmall.copyWith(color: kGrey300),
        ),
        horizontalSpaceTiny,
        FlutterLogo(size: context.autoAdaptive(s16)),
        horizontalSpaceTiny,
        Text(
          context.localization.built_with,
          style: context.bodySmall.copyWith(color: kGrey300),
        ),
        horizontalSpaceTiny,
        Icon(
          FontAwesomeIcons.solidHeart,
          size: context.autoAdaptive(s16),
          color: kRed,
        ),
      ],
    );
  }
}

class _SocialMedia extends StatelessWidget {
  final List<Social> contactList;
  final void Function(String link) onSocialTap;

  const _SocialMedia({required this.contactList, required this.onSocialTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: contactList.map((social) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: context.autoAdaptive(s12)),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            hoverColor: kWhite.withValues(alpha: 0.1),
            onTap: () => onSocialTap(social.link),
            child: AnimatedScaleWidget(
              maxScale: 1.3,
              duration: duration300,
              child: Icon(
                social.icon,
                color: kGrey300,
                size: context.autoAdaptive(s28),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
