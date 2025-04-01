import 'package:flutter/material.dart';
import 'package:e_facture/core/utils/input_validators.dart';
import 'package:e_facture/core/constants/app_routes.dart';
import 'package:e_facture/core/utils/feedback_helper.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool isLoading = false;
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> login(BuildContext context, AuthProvider authProvider) async {
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text.trim();

    emailError = InputValidators.validateEmail(context, email);
    passwordError = InputValidators.validatePassword(context, password);

    notifyListeners();

    if (emailError != null || passwordError != null) return;

    isLoading = true;
    notifyListeners();

    try {
      final result = await authProvider.login(email, password);

      if (context.mounted) {
        if (result['success'] == true) {
          FeedbackHelper.showFromCode(context, result['code'], isError: false);

          final isAdmin = authProvider.userData?.isAdmin ?? false;
          final targetRoute =
              authProvider.isFirstLogin
                  ? AppRoutes.changePassword
                  : (isAdmin
                      ? AppRoutes.adminDashboard
                      : AppRoutes.userDashboard);

          Navigator.pushReplacementNamed(context, targetRoute);
        } else {
          FeedbackHelper.showFromCode(context, result['code'], isError: true);
        }
      }
    } catch (e) {
      if (context.mounted) {
        FeedbackHelper.showFromCode(context, "errorsNetwork", isError: true);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
