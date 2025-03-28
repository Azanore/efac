import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  String? _emailError;
  String? _passwordError;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
    );
    if (!emailRegExp.hasMatch(value)) {
      return S.of(context).errorsInvalidEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }
    return null;
  }

  Future<void> _signIn() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    setState(() {
      _errorMessage = null;
      _emailError = null;
      _passwordError = null;
    });

    _emailError = _validateEmail(email);
    _passwordError = _validatePassword(password);

    if (_emailError != null || _passwordError != null) {
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final result = await authProvider.login(email, password);

      if (!mounted) return;

      if (result['success']) {
        _showMessage(S.of(context).authLoginSuccessful, isError: false);

        if (!mounted) return;

        if (authProvider.isFirstLogin) {
          Navigator.pushReplacementNamed(context, '/change-password');
        } else {
          if (authProvider.userData!.isAdmin) {
            Navigator.pushReplacementNamed(context, '/dashboard/admin');
          } else {
            Navigator.pushReplacementNamed(context, '/dashboard/user');
          }
        }
      } else {
        final msg = result['message']?.toString().trim();
        final fallback = S.of(context).errorsUnexpected;

        setState(() {
          _errorMessage = (msg?.isNotEmpty == true) ? msg! : fallback;
        });

        _showMessage(_errorMessage!, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = S.of(context).errorsNetwork;
      });
      _showMessage(_errorMessage!, isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.errorColor : Colors.green,
        duration: const Duration(seconds: 5),
      ),
    );
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
