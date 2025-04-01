import 'package:flutter/material.dart';
import 'package:e_facture/generated/l10n.dart';

class InputValidators {
  static String? validateEmail(BuildContext context, String? value) {
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

  static String? validateICE(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }

    final iceRegExp = RegExp(r"^\d{8,15}$");

    if (!iceRegExp.hasMatch(value)) {
      return S.of(context).errorsInvalidIce;
    }

    return null;
  }

  static String? validateLegalName(BuildContext context, String? value) {
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

  static String? validatePassword(
    BuildContext context,
    String? value, {
    bool strong = false,
  }) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }

    if (strong) {
      final strongRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
      if (!strongRegExp.hasMatch(value)) {
        return S.of(context).authWeakPassword;
      }
    }

    return null;
  }
}
