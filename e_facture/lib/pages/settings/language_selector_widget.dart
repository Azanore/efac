import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/core/providers/locale_provider.dart';

class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({super.key});

  @override
  _LanguageSelectorWidgetState createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  late String _selectedLanguage;

  final Map<String, Locale> _languageMap = {
    'Arabe': Locale('ar', 'AE'),
    'Français': Locale('fr', 'FR'),
    'Anglais': Locale('en', 'US'),
  };

  @override
  void initState() {
    super.initState();
    final locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    _selectedLanguage = _getLanguageName(locale.languageCode);
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'ar':
        return 'Arabe';
      case 'fr':
        return 'Français';
      case 'en':
        return 'Anglais';
      default:
        return 'Français';
    }
  }

  void _changeLanguage(String newLanguage) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(_languageMap[newLanguage]!);

    setState(() {
      _selectedLanguage = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _changeLanguage,
      itemBuilder: (context) {
        return _languageMap.keys.map((String language) {
          return PopupMenuItem<String>(
            value: language,
            child: Text(language),
          );
        }).toList();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_selectedLanguage, style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
        ],
      ),
    );
  }
}
