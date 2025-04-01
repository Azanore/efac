import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/viewmodels/auth/forgot_password_viewmodel.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child: const _ForgotPasswordBody(),
    );
  }
}

class _ForgotPasswordBody extends StatelessWidget {
  const _ForgotPasswordBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ForgotPasswordViewModel>();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).authForgotPassword,
        showBackButton: true,
        rightAction: QuickSettingsWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset('assets/images/snrt_logo.png', height: 100),
            ),
            const SizedBox(height: 20),
            CustomInputFieldWidget(
              label: S.of(context).generalSocialReason,
              hint: S.of(context).authEnterCompanyName,
              controller: vm.legalNameController,
              icon: Icons.business,
              errorText: vm.legalNameError,
            ),
            const SizedBox(height: 10),
            CustomInputFieldWidget(
              label: S.of(context).generalIce,
              hint: S.of(context).authEnterIce,
              controller: vm.iceController,
              icon: Icons.numbers,
              keyboardType: TextInputType.number,
              errorText: vm.iceError,
            ),
            const SizedBox(height: 10),
            CustomInputFieldWidget(
              label: S.of(context).generalEmail,
              hint: S.of(context).authEnterEmail,
              controller: vm.emailController,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              errorText: vm.emailError,
            ),
            const SizedBox(height: 30),
            vm.isLoading
                ? const CircularProgressIndicator()
                : CustomButtonWidget(
                  text: S.of(context).authSendLink,
                  onPressed: () => vm.submitResetRequest(context, authProvider),
                  backgroundColor: AppColors.buttonColor,
                  textColor: AppColors.buttonTextColor,
                  icon: Icons.send,
                ),
          ],
        ),
      ),
    );
  }
}
