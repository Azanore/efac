import 'package:e_facture/core/providers/user_provider.dart';
import 'package:e_facture/core/services/admin_user_service.dart';
import 'package:e_facture/core/services/admin_invoice_service.dart';
import 'package:e_facture/core/services/invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/signup_page.dart';
import 'pages/settings/change_password_page.dart';
import 'pages/auth/forgot_password_page.dart';
import 'pages/user/user_dashboard_page.dart';
import 'pages/admin/admin_dashboard_page.dart';
import 'pages/user/create_invoice_page.dart';
import 'pages/user/invoice_history_page.dart';
import 'pages/admin/admin_users_page.dart';
import 'pages/admin/admin_invoices_page.dart';
import 'core/providers/locale_provider.dart';
import 'core/providers/theme_provider.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/splash_screen.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();
  await dotenv.load(fileName: "assets/.env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => localeProvider),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => InvoiceService()),
        ChangeNotifierProvider(create: (_) => AdminUserService()),
        ChangeNotifierProvider(create: (_) => AdminInvoiceService()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Facturation',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/change-password': (context) => ChangePasswordPage(),
        '/forgot-password': (context) => ForgotPassword(),
        '/dashboard/user': (context) => DashboardUser(),
        '/dashboard/admin': (context) => DashboardAdmin(),
        '/invoice/create': (context) => CreateInvoice(),
        '/invoice/history': (context) => UserInvoicesPage(),
        '/admin/users': (context) => AdminUsersPage(),
        '/admin/invoices': (context) => AdminInvoicesPage(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('ar', 'AE'),
      ],
      locale: localeProvider.locale,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return Locale('fr', 'FR');
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return Locale('en', 'US');
      },
      theme: themeProvider.themeData,
    );
  }
}
