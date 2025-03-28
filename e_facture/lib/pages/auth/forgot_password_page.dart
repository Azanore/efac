import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/generated/l10n.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _iceController = TextEditingController();
  final TextEditingController _raisonSocialeController =
      TextEditingController();

  bool _isLoading = false;
  String? _emailError, _iceError, _raisonSocialeError;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
    );
    if (!emailRegExp.hasMatch(value)) {
      return S.of(context).errorsInvalidEmail;
    }
    return null;
  }

  String? _validateICE(String? value) {
    if (value == null || value.isEmpty) return S.of(context).errorsEmptyField;
    final iceRegExp = RegExp(r"^\d{8,15}$");
    if (!iceRegExp.hasMatch(value)) return S.of(context).errorsInvalidIce;
    return null;
  }

  String? _validateRaisonSociale(String? value) {
    if (value == null || value.isEmpty) return S.of(context).errorsEmptyField;
    if (value.length < 3) return S.of(context).errorsTooShortCompanyName;
    if (value.length > 100) return S.of(context).errorsTooLongCompanyName;
    return null;
  }

  Future<void> _submitResetRequest() async {
    final email = _emailController.text.trim();
    final ice = _iceController.text.trim();
    final legalName = _raisonSocialeController.text.trim();

    setState(() {
      _emailError = _validateEmail(email);
      _iceError = _validateICE(ice);
      _raisonSocialeError = _validateRaisonSociale(legalName);
    });

    if (_emailError != null ||
        _iceError != null ||
        _raisonSocialeError != null) {
      return;
    }

    setState(() => _isLoading = true);

    final String baseUrl = dotenv.get('API_URL');
    final String authPath = dotenv.get('AUTH_PATH');
    final url = Uri.parse('$baseUrl$authPath/forgot-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'ice': ice, 'legalName': legalName}),
      );

      if (!mounted) return;

      final data = jsonDecode(response.body);
      final message = data['message']?.toString().trim();
      final fallback = S.of(context).errorsUnexpected;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message?.isNotEmpty == true ? message! : fallback),
          backgroundColor:
              data['success'] ? AppColors.successColor : AppColors.errorColor,
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).errorsNetwork),
          backgroundColor: AppColors.errorColor,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _iceController.dispose();
    _raisonSocialeController.dispose();
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
              controller: _raisonSocialeController,
              icon: Icons.business,
              errorText: _raisonSocialeError,
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
