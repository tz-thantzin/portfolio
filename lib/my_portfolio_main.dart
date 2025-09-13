import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'presentations/configs/constants.dart';
import 'view_models/home_view_model.dart';
import 'views/home/home_view.dart';

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        title: 'Thant Zin',
        theme: ThemeData(
          useMaterial3: true,
          textTheme: _buildLocaleTextTheme(
            homeViewModel.locale ?? const Locale('en'),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: _buildLocaleTextTheme(
            homeViewModel.locale ?? const Locale('en'),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: homeViewModel.themeMode,
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(
                MediaQuery.of(context).textScaler.scale(1.0).clamp(0.6, 1.4),
              ),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        locale: homeViewModel.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeView(),
      ),
    );
  }

  TextTheme _buildLocaleTextTheme(Locale locale) {
    final List<String> fallbackFonts = <String>['NotoSansJP', 'NotoSansThai'];

    if (locale.languageCode == LanguageCode.ja.name) {
      return ThemeData.light().textTheme.apply(
        fontFamily: 'NotoSansJP',
        fontFamilyFallback: fallbackFonts,
      );
    } else if (locale.languageCode == LanguageCode.th.name) {
      return ThemeData.light().textTheme.apply(
        fontFamily: 'NotoSansThai',
        fontFamilyFallback: fallbackFonts,
      );
    } else {
      return ThemeData.light().textTheme.apply(
        fontFamily: 'MulishLocal',
        fontFamilyFallback: fallbackFonts,
      );
    }
  }
}
