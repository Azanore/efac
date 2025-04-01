import 'package:flutter/material.dart';
import 'package:e_facture/core/services/auth_service.dart';
import 'package:e_facture/core/providers/auth_provider.dart';
import 'package:e_facture/core/utils/feedback_helper.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ChangePasswordViewModel extends ChangeNotifier {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  String? currentPasswordError;
  String? newPasswordError;
  String? confirmPasswordError;

  void toggleCurrent() {
    obscureCurrent = !obscureCurrent;
    notifyListeners();
  }

  void toggleNew() {
    obscureNew = !obscureNew;
    notifyListeners();
  }

  void toggleConfirm() {
    obscureConfirm = !obscureConfirm;
    notifyListeners();
  }

  void disposeControllers() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> changePassword(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    currentPasswordError = _validatePassword(context, currentPassword);
    newPasswordError = _validateStrongPassword(context, newPassword);
    confirmPasswordError = _validateConfirmPassword(
      context,
      newPassword,
      confirmPassword,
    );

    if (currentPassword == newPassword && currentPasswordError == null) {
      newPasswordError = S.of(context).authSameOldAndNewPassword;
    }

    notifyListeners();

    if (currentPasswordError != null ||
        newPasswordError != null ||
        confirmPasswordError != null)
      return;

    isLoading = true;
    notifyListeners();

    try {
      final url =
          '${dotenv.get('API_URL')}${dotenv.get('AUTH_PATH')}/change-password';

      final response = await AuthService().authenticatedRequest(
        url,
        'POST',
        body: {
          'email': authProvider.userData?.email ?? '',
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
        token: authProvider.token!,
      );

      if (context.mounted) {
        if (response.statusCode == 200) {
          FeedbackHelper.showFromCode(
            context,
            'passwordChangedSuccess',
            isError: false,
          );

          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) {
              final isAdmin = authProvider.userData?.isAdmin ?? false;
              Navigator.pushReplacementNamed(
                context,
                isAdmin ? '/dashboard/admin' : '/dashboard/user',
              );
            }
          });
        } else {
          final responseData = json.decode(response.body);
          final errorCode = responseData['code'] ?? "errorsUnexpected";
          FeedbackHelper.showFromCode(context, errorCode, isError: true);
        }
      }
    } catch (e) {
      if (context.mounted) {
        FeedbackHelper.showFromCode(context, "errorsUnexpected", isError: true);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String? _validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) return S.of(context).errorsEmptyField;
    return null;
  }

  String? _validateStrongPassword(BuildContext context, String? password) {
    if (password == null || password.isEmpty)
      return S.of(context).errorsEmptyField;

    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasMinLength = password.length >= 8;

    if (!hasUppercase || !hasLowercase || !hasDigit || !hasMinLength) {
      return S.of(context).authWeakPassword;
    }

    return null;
  }

  String? _validateConfirmPassword(
    BuildContext context,
    String newPass,
    String? confirmPass,
  ) {
    if (confirmPass == null || confirmPass.isEmpty)
      return S.of(context).errorsEmptyField;
    if (confirmPass != newPass) return S.of(context).authPasswordMismatch;
    return null;
  }
}
