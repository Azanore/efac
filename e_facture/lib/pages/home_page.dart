import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_widget.dart';
import 'package:e_facture/core/utils/app_colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        rightAction: QuickSettingsWidget(),
        title: S.of(context).welcomeTitle,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/snrt_logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomTextWidget(
                  text: 'E-Facture',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextWidget(
                text: S.of(context).homeDescription,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // 👤 Connexion d'abord
              CustomTextWidget(
                text: S.of(context).homeHaveAccount,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomButtonWidget(
                  text: S.of(context).homeLogin,
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  backgroundColor: AppColors.buttonColor,
                  textColor: AppColors.buttonTextColor,
                  icon: Icons.login,
                ),
              ),
              const SizedBox(height: 20),

              // 🆕 Ensuite inscription
              CustomTextWidget(
                text: S.of(context).homeNoAccount,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomButtonWidget(
                  text: S.of(context).homeSignup,
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  backgroundColor: AppColors.cardColor(context),
                  textColor: AppColors.textColor(context),
                  icon: Icons.person_add,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
