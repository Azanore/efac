import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/input_validators.dart';
import 'package:e_facture/core/utils/feedback_helper.dart';
import 'package:e_facture/core/services/auth_service.dart';
import 'package:e_facture/core/constants/app_routes.dart';
import 'package:e_facture/core/constants/app_constants.dart';
import 'package:logger/logger.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _iceController = TextEditingController();
  final TextEditingController _legalNameController = TextEditingController();
  final Logger logger = Logger();

  bool _isLoading = false;
  String? _emailError, _iceError, _legalNameError;

  Future<void> _submitResetRequest() async {
    final email = _emailController.text.trim().toLowerCase();
    final ice = _iceController.text.trim();
    final legalName = _legalNameController.text.trim();

    logger.i("👤 Email: $email | ICE: $ice | Legal Name: $legalName");

    setState(() {
      _emailError = InputValidators.validateEmail(context, email);
      _iceError = InputValidators.validateICE(context, ice);
      _legalNameError = InputValidators.validateLegalName(context, legalName);
    });

    if (_emailError != null || _iceError != null || _legalNameError != null) {
      logger.w(
        "❌ Validation failed — emailError: $_emailError | iceError: $_iceError | legalNameError: $_legalNameError",
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      logger.i("📤 Sending forgot password request...");
      final result = await authProvider.forgotPassword(email, ice, legalName);

      logger.i(
        "✅ Parsed result — success: ${result['success']} | code: ${result['code']}",
      );

      if (!mounted) return;

      FeedbackHelper.showFromCode(
        context,
        result['code'],
        isError: !result['success'],
      );

      if (result['success'] == true) {
        logger.i("🎉 Reset request success");
        Future.delayed(AppConstants.redirectDelay, () {
          if (mounted) {
            logger.i("➡️ Redirecting to login");
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        });
      }
    } catch (error, stack) {
      logger.e(
        "❌ Exception during reset password request",
        error: error,
        stackTrace: stack,
      );
      if (mounted) {
        FeedbackHelper.showFromCode(context, "errorsNetwork", isError: true);
      }
    } finally {
      if (mounted) {
        logger.i("🔄 Reset request finished (loading false)");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _iceController.dispose();
    _legalNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              controller: _legalNameController,
              icon: Icons.business,
              errorText: _legalNameError,
            ),
            const SizedBox(height: 10),
            CustomInputFieldWidget(
              label: S.of(context).generalIce,
              hint: S.of(context).authEnterIce,
              controller: _iceController,
              icon: Icons.numbers,
              keyboardType: TextInputType.number,
              errorText: _iceError,
            ),
            const SizedBox(height: 10),
            CustomInputFieldWidget(
              label: S.of(context).generalEmail,
              hint: S.of(context).authEnterEmail,
              controller: _emailController,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError,
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : CustomButtonWidget(
                  text: S.of(context).authSendLink,
                  onPressed: _submitResetRequest,
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
