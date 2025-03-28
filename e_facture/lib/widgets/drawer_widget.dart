import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/core/providers/locale_provider.dart';
import 'package:e_facture/core/providers/theme_provider.dart';
import 'package:e_facture/core/services/auth_service.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/generated/l10n.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // Fonction pour obtenir le nom de la langue traduit
  String _getLanguageName(String languageCode) {
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

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    // Obtenir les données utilisateur
    final userData = authProvider.userData;
    final isAdmin = userData?.isAdmin ?? false;

    // Récupérer la langue actuelle
    final selectedLanguage = _getLanguageName(
      localeProvider.locale.languageCode,
    );

    // Dynamic colors
    final backgroundColor = AppColors.cardColor(context);
    final primaryColor = AppColors.primaryColor(context);
    final textColor = AppColors.textColor(context);
    final iconColor = AppColors.iconColor(context);

    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: <Widget>[
          // En-tête du drawer avec les informations utilisateur
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: primaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).generalSocialReason}: ${userData?.legalName ?? S.of(context).authForgotPassword}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${S.of(context).generalIce}: ${userData?.ice ?? S.of(context).authForgotPassword}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${S.of(context).generalEmail}: ${userData?.email ?? S.of(context).authForgotPassword}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Menu principal
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                if (!isAdmin)
                  ListTile(
                    leading: Icon(Icons.dashboard, color: iconColor),
                    title: Text(
                      S.of(context).navigationDashboardUser,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard/user');
                    },
                  ),

                // N'afficher le Dashboard Admin que si l'utilisateur est admin
                if (isAdmin)
                  ListTile(
                    leading: Icon(Icons.admin_panel_settings, color: iconColor),
                    title: Text(
                      S.of(context).navigationDashboardAdmin,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard/admin');
                    },
                  ),

                ListTile(
                  leading: Icon(Icons.lock, color: iconColor),
                  title: Text(
                    S.of(context).authChangePassword,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/change-password');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language, color: iconColor),
                  title: Text(
                    S.of(context).generalLanguage,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    color: backgroundColor,
                    onSelected: (String newLanguage) {
                      Locale newLocale;
                      if (newLanguage == S.of(context).languagesEnglish) {
                        newLocale = const Locale('en', 'US');
                      } else if (newLanguage == S.of(context).languagesArabic) {
                        newLocale = const Locale('ar', 'AE');
                      } else {
                        newLocale = const Locale('fr', 'FR');
                      }

                      // Appliquer le changement de langue via le provider
                      localeProvider.setLocale(newLocale);
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        S.of(context).languagesArabic,
                        S.of(context).languagesFrench,
                        S.of(context).languagesEnglish,
                      ].map<PopupMenuItem<String>>((String language) {
                        return PopupMenuItem<String>(
                          value: language,
                          child: Text(
                            language,
                            style: TextStyle(color: textColor),
                          ),
                        );
                      }).toList();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedLanguage,
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                        Icon(Icons.arrow_drop_down, color: iconColor),
                      ],
                    ),
                  ),
                ),

                // Switch pour le thème
                ListTile(
                  leading: Icon(
                    themeProvider.isDarkTheme
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: iconColor,
                  ),
                  title: Text(
                    S.of(context).generalDarkMode,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  trailing: Switch(
                    value: themeProvider.isDarkTheme,
                    activeColor: AppColors.buttonColor,
                    onChanged: (value) {
                      // Basculer le thème via le provider
                      themeProvider.toggleTheme();
                    },
                  ),
                ),
              ],
            ),
          ),

          // Bouton Déconnexion amélioré avec style à jour
          SizedBox(
            width: double.infinity, // Prend toute la largeur
            child: CustomButtonWidget(
              text: S.of(context).generalLogout,
              onPressed: () async {
                await authProvider.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home',
                  (Route<dynamic> route) => false,
                );
              },
              backgroundColor: AppColors.errorColor,
              textColor: Colors.white,
              icon: Icons.logout,
              borderRadius: 0,
            ),
          ),

          // Petit espace au bas du drawer pour éviter que le bouton soit trop près du bord
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
