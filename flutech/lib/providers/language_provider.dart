import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('tr');
  final List<Locale> _supportedLocales = const [
    Locale('tr'), // Turkish
    Locale('en'), // English
    // Add more languages as needed
  ];

  Locale get locale => _locale;
  List<Locale> get supportedLocales => _supportedLocales;

  LanguageProvider() {
    _loadLocaleFromPrefs();
  }

  void setLocale(Locale locale) {
    if (!_supportedLocales.contains(locale)) return;

    _locale = locale;
    _saveLocaleToPrefs();
    notifyListeners();
  }

  String getDisplayLanguage(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'tr':
        return 'Türkçe';
      default:
        return locale.languageCode;
    }
  }

  Future<void> _loadLocaleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('languageCode');

    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  Future<void> _saveLocaleToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', _locale.languageCode);
  }
}
