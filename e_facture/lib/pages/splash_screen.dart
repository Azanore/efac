import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/core/providers/auth_provider.dart';
import 'package:e_facture/generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _initialize();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  void _initialize() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.initAuth();

    await Future.delayed(Duration(seconds: 2));

    if (authProvider.isAuthenticated) {
      if (authProvider.isFirstLogin) {
        // 🔐 Forcer la déconnexion si mot de passe temporaire non changé
        await authProvider.logout(context);
        Navigator.pushReplacementNamed(context, '/home');
      } else if (authProvider.userData!.isAdmin) {
        Navigator.pushReplacementNamed(context, '/dashboard/admin');
      } else {
        Navigator.pushReplacementNamed(context, '/dashboard/user');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: Center(
        child: FadeTransition(
          opacity: _logoAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/snrt_logo.png',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 20),
              Text(
                'E-Facture',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor(context),
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 20),
              Text(
                S.of(context).splashPreparingApp,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor(context).withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
