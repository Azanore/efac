import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';

  // Méthode pour récupérer la langue stockée localement
  Future<Locale?> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(_languageKey);
    if (languageCode != null) {
      if (languageCode == 'en') {
        return Locale('en', 'US');
      } else if (languageCode == 'ar') {
        return Locale('ar', 'AE');
      } else if (languageCode == 'fr') {
        return Locale('fr', 'FR');
      }
    }
    return null; // Si aucune langue n'est stockée, retourner null.
  }

  // Méthode pour enregistrer la langue
  Future<void> saveLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    String languageCode = locale.languageCode;
    await prefs.setString(_languageKey, languageCode);
  }
}
