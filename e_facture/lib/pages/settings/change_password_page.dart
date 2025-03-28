import 'dart:convert';
import 'package:e_facture/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart'; // Logger package

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _currentPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final Logger _logger = Logger(); // Logger instance

  void _toggleCurrentPasswordVisibility() {
    setState(() {
      _obscureCurrentPassword = !_obscureCurrentPassword;
    });
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  String? _validateStrongPassword(String? password) {
    if (password == null || password.isEmpty) {
      return S.of(context).errorsEmptyField;
    }

    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasMinLength = password.length >= 8;

    if (!hasUppercase || !hasLowercase || !hasDigit || !hasMinLength) {
      return S.of(context).authWeakPassword;
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }
    if (value != _newPasswordController.text) {
      return S.of(context).authPasswordMismatch;
    }
    return null;
  }

  Future<void> _changePassword() async {
    final String currentPassword = _currentPasswordController.text.trim();
    final String newPassword = _newPasswordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _errorMessage = null;
      _currentPasswordError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;
    });

    // Validation
    _currentPasswordError = _validatePassword(currentPassword);
    _newPasswordError = _validateStrongPassword(newPassword);
    _confirmPasswordError = _validateConfirmPassword(confirmPassword);

    // Vérification : nouveau ≠ ancien
    if (_currentPasswordError == null &&
        _newPasswordError == null &&
        currentPassword == newPassword) {
      _newPasswordError = S.of(context).authSameOldAndNewPassword;
    }

    if (_currentPasswordError != null ||
        _newPasswordError != null ||
        _confirmPasswordError != null) {
      setState(() {}); // Afficher les erreurs
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final String baseUrl = dotenv.get('API_URL');
      final String authPath = dotenv.get('AUTH_PATH');
      final url = Uri.parse('$baseUrl$authPath/change-password');

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      _logger.i(
        'Change password request sent with token: ${authProvider.token}',
      );

      if (authProvider.token == null) {
        throw Exception(S.of(context).authMissingToken);
      }

      final email = authProvider.userData?.email ?? "user@example.com";

      final response = await authProvider.authenticatedRequest(
        url.toString(),
        'POST',
        body: {
          'email': email,
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );

      if (mounted) {
        if (response.statusCode == 200) {
          _showMessage(S.of(context).authPasswordChanged, isError: false);

          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              if (authProvider.userData?.isAdmin == true) {
                Navigator.pushReplacementNamed(context, '/dashboard/admin');
              } else {
                Navigator.pushReplacementNamed(context, '/dashboard/user');
              }
            }
          });
        } else {
          String errorMsg = "";
          try {
            if (response.body.isNotEmpty) {
              final errorData = json.decode(response.body);
              errorMsg =
                  errorData['message'] ??
                  errorData['error'] ??
                  errorData['detail'] ??
                  S.of(context).errorsUnexpected;
            } else {
              errorMsg = S.of(context).errorsNetwork;
            }
          } catch (_) {
            errorMsg = S.of(context).errorsUnexpected;
          }
          throw Exception(errorMsg);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          // Standardize error messages
          _errorMessage =
              e.toString().contains('Exception:')
                  ? S.of(context).errorsUnexpected
                  : e.toString().replaceAll('Exception: ', '');
        });
        _showMessage(_errorMessage!, isError: true);
      }
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
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).authChangePassword,
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
                label: S.of(context).authOldPassword,
                hint: S.of(context).authEnterOldPassword,
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                icon: Icons.lock,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureCurrentPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.lightIconColor,
                  ),
                  onPressed: _toggleCurrentPasswordVisibility,
                ),
                errorText: _currentPasswordError,
              ),
              const SizedBox(height: 10),
              CustomInputFieldWidget(
                label: S.of(context).authNewPassword,
                hint: S.of(context).authEnterNewPassword,
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                icon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.lightIconColor,
                  ),
                  onPressed: _toggleNewPasswordVisibility,
                ),
                errorText: _newPasswordError,
              ),
              const SizedBox(height: 10),
              CustomInputFieldWidget(
                label: S.of(context).authConfirmPassword,
                hint: S.of(context).authConfirmNewPassword,
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                icon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.lightIconColor,
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
                errorText: _confirmPasswordError,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButtonWidget(
                    text: S.of(context).authChangePassword,
                    onPressed: _changePassword,
                    backgroundColor: AppColors.buttonColor,
                    textColor: AppColors.buttonTextColor,
                    icon: Icons.lock_open,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
