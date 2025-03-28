import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('fr', 'FR'); // Locale par défaut

  Locale get locale => _locale;

  // Fonction pour changer la locale
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();

    // Sauvegarder la langue dans SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }

  // Fonction pour changer la langue et notifier les autres widgets
  Future<void> changeLanguage(Locale newLocale) async {
    await setLocale(newLocale); // Change la langue et la sauvegarde
  }

  // Charger la locale depuis SharedPreferences
  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');

    // Si les données existent, on les applique, sinon on garde la locale par défaut
    if (langCode != null && countryCode != null && countryCode.isNotEmpty) {
      _locale = Locale(langCode, countryCode);
    } else {
      _locale = Locale(
        'fr',
        'FR',
      ); // Si rien n'est trouvé, on applique la locale par défaut
    }
    notifyListeners();
  }
}
