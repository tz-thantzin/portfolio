import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'my_portfolio_main.dart';
import 'utils/session.dart';
import 'view_models/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(const HashUrlStrategy());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(sessionUtil: SessionUtil(prefs: _prefs)),
      child: const MyPortfolioApp(),
    ),
  );
}
