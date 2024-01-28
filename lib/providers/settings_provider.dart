import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String _locale = 'en'; // Default locale is English

  String get locale => _locale;

  void setLocale(String newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  String getFullLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'it':
        return 'Italiano';
      // Add more cases for other languages if needed
      default:
        return 'Unknown';
    }
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _locale = prefs.getString('locale') ?? 'en';
    notifyListeners();
  }
}
