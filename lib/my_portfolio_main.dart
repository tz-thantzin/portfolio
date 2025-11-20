import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:portfolio/core/routing/routes.dart';
import 'package:portfolio/l10n/app_localizations.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

class MyPortfolioMain extends ConsumerWidget {
  const MyPortfolioMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Layout(
      child: MaterialApp.router(
        title: 'Thant Zin',
        theme: context.theme(),
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(
                mediaQuery.textScaler.scale(1.0).clamp(0.6, 1.4),
              ),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
