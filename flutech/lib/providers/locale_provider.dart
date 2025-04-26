import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutech/constants/app_constants.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('tr'); // Default to Turkish

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocaleFromPrefs();
  }

  void setLocale(Locale newLocale) {
    if (!AppConstants.supportedLocales.contains(newLocale)) return;

    _locale = newLocale;
    _saveLocaleToPrefs(newLocale.languageCode);
    notifyListeners();
  }

  void toggleLocale() {
    final currentCode = _locale.languageCode;
    if (currentCode == 'tr') {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('tr'));
    }
  }

  Future<void> _loadLocaleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language');
    if (language != null) {
      _locale = Locale(language);
    }
    notifyListeners();
  }

  Future<void> _saveLocaleToPrefs(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }
}
