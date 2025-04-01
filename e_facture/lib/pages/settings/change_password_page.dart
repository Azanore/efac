import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/core/providers/auth_provider.dart';
import 'package:e_facture/viewmodels/settings/change_password_viewmodel.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child: const _ChangePasswordBody(),
    );
  }
}

class _ChangePasswordBody extends StatelessWidget {
  const _ChangePasswordBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChangePasswordViewModel>();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).authChangePassword,
        showBackButton: true,
        rightAction: QuickSettingsWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/snrt_logo.png', height: 100),
            const SizedBox(height: 20),
            CustomInputFieldWidget(
              label: S.of(context).authOldPassword,
              hint: S.of(context).authEnterOldPassword,
              controller: vm.currentPasswordController,
              obscureText: vm.obscureCurrent,
              icon: Icons.lock,
              suffixIcon: IconButton(
                icon: Icon(
                  vm.obscureCurrent ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.lightIconColor,
                ),
                onPressed: vm.toggleCurrent,
              ),
              errorText: vm.currentPasswordError,
            ),
            const SizedBox(height: 10),
            CustomInputFieldWidget(
              label: S.of(context).authNewPassword,
              hint: S.of(context).authEnterNewPassword,
              controller: vm.newPasswordController,
              obscureText: vm.obscureNew,
              icon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  vm.obscureNew ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.lightIconColor,
                ),
                onPressed: vm.toggleNew,
              ),
              errorText: vm.newPasswordError,
            ),
            const SizedBox(height: 10),
            CustomInputFieldWidget(
              label: S.of(context).authConfirmPassword,
              hint: S.of(context).authConfirmNewPassword,
              controller: vm.confirmPasswordController,
              obscureText: vm.obscureConfirm,
              icon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  vm.obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.lightIconColor,
                ),
                onPressed: vm.toggleConfirm,
              ),
              errorText: vm.confirmPasswordError,
            ),
            const SizedBox(height: 20),
            vm.isLoading
                ? const CircularProgressIndicator()
                : CustomButtonWidget(
                    text: S.of(context).authChangePassword,
                    onPressed: () => vm.changePassword(context, authProvider),
                    backgroundColor: AppColors.buttonColor,
                    textColor: AppColors.buttonTextColor,
                    icon: Icons.lock_open,
                  ),
          ],
        ),
      ),
    );
  }
}
