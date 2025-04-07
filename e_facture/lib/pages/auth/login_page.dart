import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/viewmodels/auth/login_viewmodel.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).authLoginPageTitle,
        showBackButton: true,
        rightAction: QuickSettingsWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset('assets/images/snrt_logo.png', height: 100),
            ),
            const SizedBox(height: 20),
            CustomInputFieldWidget(
              label: S.of(context).generalEmail,
              hint: S.of(context).authEnterEmail,
              controller: vm.emailController,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              errorText: vm.emailError,
            ),
            const SizedBox(height: 10),
            CustomInputFieldWidget(
              label: S.of(context).generalPassword,
              hint: S.of(context).authEnterPassword,
              controller: vm.passwordController,
              obscureText: vm.obscurePassword,
              icon: Icons.lock,
              errorText: vm.passwordError,
              suffixIcon: IconButton(
                icon: Icon(
                  vm.obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.lightIconColor,
                ),
                onPressed: vm.togglePasswordVisibility,
              ),
            ),
            const SizedBox(height: 20),
            vm.isLoading
                ? const CircularProgressIndicator()
                : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        text: S.of(context).homeLogin,
                        onPressed: () => vm.login(context, authProvider),
                        backgroundColor: AppColors.buttonColor,
                        textColor: AppColors.buttonTextColor,
                        icon: Icons.login,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment:
                          Directionality.of(context) == TextDirection.rtl
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: Text(
                          S.of(context).authForgotPassword,
                          style: TextStyle(
                            color: AppColors.lightPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
