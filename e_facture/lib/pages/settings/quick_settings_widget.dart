import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/core/providers/locale_provider.dart';
import 'package:e_facture/core/providers/theme_provider.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/generated/l10n.dart';

class QuickSettingsWidget extends StatelessWidget {
  const QuickSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings, color: AppColors.buttonTextColor),
      onPressed: () => _showSettingsDialog(context),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => const SettingsDialogContent(),
    );
  }
}

class SettingsDialogContent extends StatelessWidget {
  const SettingsDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.cardColor(context),
          title: Text(
            S.of(context).generalSettings,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor(context),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageSelector(context, localeProvider),
              const SizedBox(height: 16),
              _buildThemeSelector(context, themeProvider),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor(context),
              ),
              child: Text(S.of(context).generalCancel),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    LocaleProvider localeProvider,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.language, color: AppColors.primaryColor(context)),
            const SizedBox(width: 8),
            Text(
              S.of(context).generalLanguage,
              style: TextStyle(color: AppColors.textColor(context)),
            ),
          ],
        ),
        DropdownButton<String>(
          value: _getLanguageName(context, localeProvider.locale.languageCode),
          underline: Container(),
          dropdownColor: AppColors.secondaryColor(context),
          style: TextStyle(color: AppColors.textColor(context)),
          onChanged: (value) {
            if (value == S.of(context).languagesArabic) {
              localeProvider.setLocale(const Locale('ar', 'AE'));
            } else if (value == S.of(context).languagesEnglish) {
              localeProvider.setLocale(const Locale('en', 'US'));
            } else {
              localeProvider.setLocale(const Locale('fr', 'FR'));
            }
          },
          items:
              [
                S.of(context).languagesArabic,
                S.of(context).languagesFrench,
                S.of(context).languagesEnglish,
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: AppColors.textColor(context)),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildThemeSelector(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              AppColors.themeModeIcon(context),
              color: AppColors.primaryColor(context),
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).generalDarkMode,
              style: TextStyle(color: AppColors.textColor(context)),
            ),
          ],
        ),
        Switch(
          value: themeProvider.isDarkTheme,
          activeColor: AppColors.buttonColor,
          onChanged: (_) => themeProvider.toggleTheme(),
        ),
      ],
    );
  }

  String _getLanguageName(BuildContext context, String languageCode) {
    switch (languageCode) {
      case 'ar':
        return S.of(context).languagesArabic;
      case 'fr':
        return S.of(context).languagesFrench;
      case 'en':
        return S.of(context).languagesEnglish;
      default:
        return S.of(context).languagesFrench;
    }
  }
}
