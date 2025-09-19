import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi!'**
  String get hi;

  /// No description provided for @i_am.
  ///
  /// In en, this message translates to:
  /// **'I\'m'**
  String get i_am;

  /// No description provided for @thantzin.
  ///
  /// In en, this message translates to:
  /// **'Thant Zin'**
  String get thantzin;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @see_my_work.
  ///
  /// In en, this message translates to:
  /// **'See My Works'**
  String get see_my_work;

  /// No description provided for @work_experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get work_experience;

  /// No description provided for @skill.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skill;

  /// No description provided for @follow_me.
  ///
  /// In en, this message translates to:
  /// **'Follow Me'**
  String get follow_me;

  /// No description provided for @download_resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get download_resume;

  /// No description provided for @creative_mobile_app_developer.
  ///
  /// In en, this message translates to:
  /// **'Creative Mobile App Developer '**
  String get creative_mobile_app_developer;

  /// No description provided for @year_of_work_experience.
  ///
  /// In en, this message translates to:
  /// **'11+'**
  String get year_of_work_experience;

  /// No description provided for @years_success.
  ///
  /// In en, this message translates to:
  /// **'Years of \nSuccess'**
  String get years_success;

  /// No description provided for @senior_mobile_developer.
  ///
  /// In en, this message translates to:
  /// **'Senior Mobile Application Developer | Team Lead'**
  String get senior_mobile_developer;

  /// No description provided for @about_me.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get about_me;

  /// No description provided for @i_am_developer.
  ///
  /// In en, this message translates to:
  /// **'I\'m Mobile App Developer'**
  String get i_am_developer;

  /// No description provided for @about_me_description.
  ///
  /// In en, this message translates to:
  /// **'I am an experienced mobile application developer with over 11 years of expertise in Flutter and iOS development. Throughout my career, I have successfully led teams, delivering high-quality, user-friendly applications. I enjoy solving complex technical challenges and mentoring team members to achieve their full potential. My focus is on creating elegant, performant, and maintainable apps that provide exceptional user experiences.'**
  String get about_me_description;

  /// No description provided for @technologies.
  ///
  /// In en, this message translates to:
  /// **'Technologies I have worked with:'**
  String get technologies;

  /// No description provided for @programming_languages_tools.
  ///
  /// In en, this message translates to:
  /// **'Programming Languages & Tools'**
  String get programming_languages_tools;

  /// No description provided for @workflows_title.
  ///
  /// In en, this message translates to:
  /// **'Workflows'**
  String get workflows_title;

  /// No description provided for @workflows.
  ///
  /// In en, this message translates to:
  /// **'Responsive Design|Cross Functional Teams|Waterfall Development|Agile Development & Scrum|Team Leading & Task Delegation|Conducting code reviews and sprint planning'**
  String get workflows;

  /// No description provided for @freelance_title.
  ///
  /// In en, this message translates to:
  /// **'Freelance Mobile Application Developer'**
  String get freelance_title;

  /// No description provided for @freelance_company.
  ///
  /// In en, this message translates to:
  /// **''**
  String get freelance_company;

  /// No description provided for @freelance_period.
  ///
  /// In en, this message translates to:
  /// **'Apr 2024 – Present'**
  String get freelance_period;

  /// No description provided for @mobile_lead_title.
  ///
  /// In en, this message translates to:
  /// **'Mobile Team Lead'**
  String get mobile_lead_title;

  /// No description provided for @mobile_lead_company.
  ///
  /// In en, this message translates to:
  /// **'TechFun Myanmar Co., Ltd., Yangon'**
  String get mobile_lead_company;

  /// No description provided for @mobile_lead_period.
  ///
  /// In en, this message translates to:
  /// **'Nov 2019 – Mar 2024'**
  String get mobile_lead_period;

  /// No description provided for @senior_dev_title.
  ///
  /// In en, this message translates to:
  /// **'Senior Mobile Application Developer'**
  String get senior_dev_title;

  /// No description provided for @senior_dev_company.
  ///
  /// In en, this message translates to:
  /// **'TechFun Myanmar Co., Ltd., Yangon'**
  String get senior_dev_company;

  /// No description provided for @senior_dev_period.
  ///
  /// In en, this message translates to:
  /// **'Nov 2017 – Oct 2019'**
  String get senior_dev_period;

  /// No description provided for @mid_senior_dev_title.
  ///
  /// In en, this message translates to:
  /// **'Mid-Senior Mobile Application Developer'**
  String get mid_senior_dev_title;

  /// No description provided for @mid_senior_dev_company.
  ///
  /// In en, this message translates to:
  /// **'TechFun Myanmar Co., Ltd., Yangon'**
  String get mid_senior_dev_company;

  /// No description provided for @mid_senior_dev_period.
  ///
  /// In en, this message translates to:
  /// **'Apr 2016 – Oct 2017'**
  String get mid_senior_dev_period;

  /// No description provided for @research_leader_title.
  ///
  /// In en, this message translates to:
  /// **'Researching Leader'**
  String get research_leader_title;

  /// No description provided for @research_leader_company.
  ///
  /// In en, this message translates to:
  /// **'Acroquest Myanmar Technology Co., Ltd., Yangon'**
  String get research_leader_company;

  /// No description provided for @research_leader_period.
  ///
  /// In en, this message translates to:
  /// **'Oct 2015 – Dec 2015'**
  String get research_leader_period;

  /// No description provided for @software_engineer_title.
  ///
  /// In en, this message translates to:
  /// **'Software Engineer'**
  String get software_engineer_title;

  /// No description provided for @software_engineer_company.
  ///
  /// In en, this message translates to:
  /// **'Acroquest Myanmar Technology Co., Ltd., Yangon'**
  String get software_engineer_company;

  /// No description provided for @software_engineer_period.
  ///
  /// In en, this message translates to:
  /// **'May 2014 – Sep 2015'**
  String get software_engineer_period;

  /// No description provided for @portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// No description provided for @view_project.
  ///
  /// In en, this message translates to:
  /// **'View Project'**
  String get view_project;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @get_in_touch.
  ///
  /// In en, this message translates to:
  /// **'Get in touch'**
  String get get_in_touch;

  /// No description provided for @schedule_appointment.
  ///
  /// In en, this message translates to:
  /// **'Schedule an Appointment'**
  String get schedule_appointment;

  /// No description provided for @go_home.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get go_home;

  /// No description provided for @page_not_found.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get page_not_found;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
