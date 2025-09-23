import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:portfolio/data/data_sources/contact_datasource.dart';
import 'package:portfolio/data/repositories/contact_impl.dart';
import 'package:portfolio/domain/use_cases/contact_usecase.dart';
import 'package:portfolio/route/routes.dart';
import 'package:portfolio/view_models/contact_view_model.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'utils/extensions/theme_ex.dart';
import 'view_models/home_view_model.dart';

class MyPortfolioMain extends StatelessWidget {
  const MyPortfolioMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ChangeNotifierProvider<ContactViewModel>(
          create: (_) => ContactViewModel(
            ContactUseCase(
              ContactImpl(
                ContactDatasource(firestore: FirebaseFirestore.instance),
              ),
            ),
          ),
        ),
      ],
      child: const MyPortfolioApp(),
    );
  }
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp.router(
        title: 'Thant Zin',
        theme: context.theme(),
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
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
