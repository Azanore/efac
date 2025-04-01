import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/services/auth_service.dart';
import 'package:e_facture/core/utils/input_validators.dart';
import 'package:e_facture/core/utils/feedback_helper.dart';
import 'package:e_facture/core/constants/app_routes.dart';
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Logger logger = Logger();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();

    logger.i("👤 Email: $email");
    logger.i("🔒 Password length: ${password.length}");

    setState(() {
      _emailError = InputValidators.validateEmail(context, email);
      _passwordError = InputValidators.validatePassword(context, password);
    });

    if (_emailError != null || _passwordError != null) {
      logger.w(
        "❌ Validation failed — emailError: $_emailError | passwordError: $_passwordError",
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      logger.i("📤 Sending login request...");
      final result = await authProvider.login(email, password);

      logger.i(
        "✅ Parsed result — success: ${result['success']} | code: ${result['code']}",
      );

      if (!mounted) return;

      if (result['success'] == true) {
        logger.i("🎉 Login success");
        FeedbackHelper.showFromCode(context, result['code'], isError: false);

        if (authProvider.isFirstLogin) {
          logger.i("🔁 Redirecting to change-password");
          Navigator.pushReplacementNamed(context, AppRoutes.changePassword);
        } else {
          final isAdmin = authProvider.userData?.isAdmin ?? false;
          final targetRoute =
              isAdmin ? AppRoutes.adminDashboard : AppRoutes.userDashboard;
          logger.i("➡️ Redirecting to: $targetRoute");
          Navigator.pushReplacementNamed(context, targetRoute);
        }
      } else {
        FeedbackHelper.showFromCode(context, result['code'], isError: true);
      }
    } catch (error, stack) {
      logger.e("❌ Exception during login", error: error, stackTrace: stack);
      if (mounted) {
        FeedbackHelper.showFromCode(context, "errorsNetwork", isError: true);
      }
    } finally {
      if (mounted) {
        logger.i("🔄 Login finished (loading false)");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).authLoginPageTitle,
        showBackButton: true,
        rightAction: QuickSettingsWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                controller: _emailController,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
              ),
              const SizedBox(height: 10),
              CustomInputFieldWidget(
                label: S.of(context).generalPassword,
                hint: S.of(context).authEnterPassword,
                controller: _passwordController,
                obscureText: _obscurePassword,
                icon: Icons.lock,
                errorText: _passwordError,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.lightIconColor,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButtonWidget(
                        text: S.of(context).homeLogin,
                        onPressed: _signIn,
                        backgroundColor: AppColors.buttonColor,
                        textColor: AppColors.buttonTextColor,
                        icon: Icons.login,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgotPassword,
                          );
                        },
                        child: Text(
                          S.of(context).authForgotPassword,
                          style: TextStyle(
                            color: AppColors.lightPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
