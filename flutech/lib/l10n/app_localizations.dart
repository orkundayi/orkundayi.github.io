import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get heroTitle;

  /// No description provided for @heroDescription.
  ///
  /// In en, this message translates to:
  /// **'I develop modern, functional, and high-performance mobile applications with Flutter. Let\'s work together to take your digital projects to the next level!'**
  String get heroDescription;

  /// No description provided for @viewProjects.
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get viewProjects;

  /// No description provided for @contactMe.
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contactMe;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Flutech.Dev'**
  String get companyName;

  /// No description provided for @allRightsReserved.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved. This website is created with Flutter.'**
  String get allRightsReserved;

  /// No description provided for @openInGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Open in Google Play'**
  String get openInGooglePlay;

  /// No description provided for @prjectFeatures.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get prjectFeatures;

  /// No description provided for @backToProjects.
  ///
  /// In en, this message translates to:
  /// **'Back to Projects'**
  String get backToProjects;

  /// No description provided for @abount.
  ///
  /// In en, this message translates to:
  /// **''**
  String get abount;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMe;

  /// No description provided for @letsTalk.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Talk'**
  String get letsTalk;

  /// No description provided for @getInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get getInTouch;

  /// No description provided for @mobileAppDevTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile App Development'**
  String get mobileAppDevTitle;

  /// No description provided for @mobileAppDevDesc.
  ///
  /// In en, this message translates to:
  /// **'I develop high-performance, scalable iOS and Android applications with Flutter, focusing on robust architecture and modern UI.'**
  String get mobileAppDevDesc;

  /// No description provided for @uiUxDesignTitle.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Design'**
  String get uiUxDesignTitle;

  /// No description provided for @uiUxDesignDesc.
  ///
  /// In en, this message translates to:
  /// **'I deliver innovative and user-centric UI/UX designs that enhance usability and engagement.'**
  String get uiUxDesignDesc;

  /// No description provided for @apiIntegrationTitle.
  ///
  /// In en, this message translates to:
  /// **'API Integration'**
  String get apiIntegrationTitle;

  /// No description provided for @apiIntegrationDesc.
  ///
  /// In en, this message translates to:
  /// **'Seamless integration with RESTful APIs, .NET, Firebase, and other third-party platforms for secure and scalable data exchange.'**
  String get apiIntegrationDesc;

  /// No description provided for @backendSolutionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Backend Solutions'**
  String get backendSolutionsTitle;

  /// No description provided for @backendSolutionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Custom backend solutions using .NET, Firebase, or cloud services to ensure security, scalability, and reliability for your applications.'**
  String get backendSolutionsDesc;

  /// No description provided for @appArchitectureTitle.
  ///
  /// In en, this message translates to:
  /// **'App Architecture'**
  String get appArchitectureTitle;

  /// No description provided for @appArchitectureDesc.
  ///
  /// In en, this message translates to:
  /// **'Designing maintainable, scalable, and clean application architectures tailored to your business needs.'**
  String get appArchitectureDesc;

  /// No description provided for @whatICanDoForYou.
  ///
  /// In en, this message translates to:
  /// **'What I Can Do For You'**
  String get whatICanDoForYou;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @languageTr.
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get languageTr;

  /// No description provided for @scrollDown.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get scrollDown;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

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

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @projectFeatures.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get projectFeatures;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'As a dedicated Flutter developer, I create modern, user-centric mobile applications with a focus on clean code, robust architecture, and elegant design. My expertise includes seamless API integrations and backend solutions, enabling me to transform ideas into high-quality digital products. I am committed to continuous learning and delivering outstanding results in every project. Let\'s work together to bring your vision to life.'**
  String get aboutDescription;

  /// The year the developer started
  ///
  /// In en, this message translates to:
  /// **'Developer since {date}'**
  String sinceDeveloper(Object date);

  /// No description provided for @personalProjects.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive personal projects and a continuous learning mindset'**
  String get personalProjects;

  /// No description provided for @flutterDartFocused.
  ///
  /// In en, this message translates to:
  /// **'Specializing in Flutter, Dart, and scalable cross-platform architectures'**
  String get flutterDartFocused;

  /// No description provided for @contactInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInfoTitle;

  /// No description provided for @contactInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'You can use my email address to contact me.'**
  String get contactInfoDesc;

  /// No description provided for @emailTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTitle;

  /// No description provided for @githubDesc.
  ///
  /// In en, this message translates to:
  /// **'Code & Projects'**
  String get githubDesc;

  /// No description provided for @linkedinDesc.
  ///
  /// In en, this message translates to:
  /// **'Professional Profile'**
  String get linkedinDesc;

  /// No description provided for @downloadApk.
  ///
  /// In en, this message translates to:
  /// **'Download APK'**
  String get downloadApk;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
