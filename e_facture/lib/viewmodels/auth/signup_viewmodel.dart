import 'package:flutter/material.dart';
import 'package:e_facture/core/utils/input_validators.dart';
import 'package:e_facture/core/constants/app_routes.dart';
import 'package:e_facture/core/constants/app_constants.dart';
import 'package:e_facture/core/utils/feedback_helper.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class SignupViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController iceController = TextEditingController();
  final TextEditingController legalNameController = TextEditingController();

  bool isLoading = false;
  String? emailError;
  String? iceError;
  String? legalNameError;

  void disposeControllers() {
    emailController.dispose();
    iceController.dispose();
    legalNameController.dispose();
  }

  Future<void> register(BuildContext context, AuthProvider authProvider) async {
    final email = emailController.text.trim().toLowerCase();
    final ice = iceController.text.trim();
    final legalName = legalNameController.text.trim();

    emailError = InputValidators.validateEmail(context, email);
    iceError = InputValidators.validateICE(context, ice);
    legalNameError = InputValidators.validateLegalName(context, legalName);

    notifyListeners();

    if (emailError != null || iceError != null || legalNameError != null)
      return;

    isLoading = true;
    notifyListeners();

    try {
      final result = await authProvider.register(email, ice, legalName);

      if (context.mounted) {
        FeedbackHelper.showFromCode(
          context,
          result['code'],
          isError: !result['success'],
        );

        if (result['success'] == true) {
          Future.delayed(AppConstants.redirectDelay, () {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          });
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
