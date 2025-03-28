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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _raisonSocialeController =
      TextEditingController();
  final TextEditingController _iceController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _emailError;
  String? _iceError;
  String? _raisonSocialeError;

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

  String? _validateICE(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }
    final iceRegExp = RegExp(r"^\d{8,15}$");
    if (!iceRegExp.hasMatch(value)) {
      return S.of(context).errorsInvalidIce;
    }
    return null;
  }

  String? _validateRaisonSociale(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }
    if (value.length < 3) {
      return S.of(context).errorsTooShortCompanyName;
    }
    if (value.length > 100) {
      return S.of(context).errorsTooLongCompanyName;
    }
    return null;
  }

  Future<String?> _register(String email, String ice, String legalName) async {
    final String baseUrl = dotenv.get('API_URL');
    final String authPath = dotenv.get('AUTH_PATH');
    final url = Uri.parse('$baseUrl$authPath/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'ice': ice, 'legalName': legalName}),
      );

      if (response.statusCode == 201) {
        return null;
      } else {
        String errorMsg = '';
        try {
          if (response.body.isNotEmpty) {
            final errorData = json.decode(response.body);
            if (errorData != null && errorData.containsKey('message')) {
              errorMsg = errorData['message'];
            }
          }
        } catch (_) {}
        return errorMsg.isNotEmpty ? errorMsg : S.of(context).errorsUnexpected;
      }
    } catch (_) {
      return S.of(context).errorsNetwork;
    }
  }

  Future<void> _signUp() async {
    final String raisonSociale = _raisonSocialeController.text.trim();
    final String ice = _iceController.text.trim();
    final String email = _emailController.text.trim();

    setState(() {
      _errorMessage = null;
      _emailError = null;
      _iceError = null;
      _raisonSocialeError = null;
    });

    _emailError = _validateEmail(email);
    _iceError = _validateICE(ice);
    _raisonSocialeError = _validateRaisonSociale(raisonSociale);

    if (_emailError != null ||
        _iceError != null ||
        _raisonSocialeError != null) {
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String? error = await _register(email, ice, raisonSociale);

    if (!mounted) return;

    if (error == null) {
      _showMessage(S.of(context).authRegistrationSuccessful, isError: false);

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    } else {
      setState(() {
        _errorMessage = error;
      });
      _showMessage(_errorMessage!, isError: true);
    }

    setState(() {
      _isLoading = false;
    });
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
        title: S.of(context).authSignupPageTitle,
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
                label: S.of(context).generalSocialReason,
                hint: S.of(context).authEnterCompanyName,
                controller: _raisonSocialeController,
                icon: Icons.business,
                keyboardType: TextInputType.text,
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
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButtonWidget(
                    text: S.of(context).authSignupButton,
                    onPressed: _signUp,
                    backgroundColor: AppColors.buttonColor,
                    textColor: AppColors.buttonTextColor,
                    icon: Icons.person_add,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _raisonSocialeController.dispose();
    _iceController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
