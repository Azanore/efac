import 'package:flutter/material.dart';
import 'package:e_facture/core/themes/app_theme.dart';
import 'package:e_facture/core/services/theme_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  final ThemeService _themeService = ThemeService();

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkTheme => _isDarkTheme;

  ThemeData get themeData =>
      _isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _themeService.saveTheme(_isDarkTheme);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    _isDarkTheme = await _themeService.loadTheme();
    notifyListeners();
  }
}
