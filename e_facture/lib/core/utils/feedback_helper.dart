import 'package:flutter/material.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/app_colors.dart';

class FeedbackHelper {
  static void showFromCode(
    BuildContext context,
    String? code, {
    bool isError = true,
  }) {
    final fallback = S.of(context).errorsUnexpected;

    final translations = <String, String>{
      // ✅ Success messages
      "loginSuccess": S.of(context).loginSuccess,
      "registrationSuccess": S.of(context).registrationSuccess,
      "resetEmailSent": S.of(context).resetEmailSent,
      "passwordChangedSuccess": S.of(context).authPasswordChanged,
      "profileRetrieved": S.of(context).profileRetrieved,

      // ✅ Error messages
      "errorsMissingFields": S.of(context).errorsMissingFields,
      "errorsInvalidEmail": S.of(context).errorsInvalidEmail,
      "errorsInvalidIce": S.of(context).errorsInvalidIce,
      "errorsInvalidLegalName": S.of(context).errorsInvalidLegalName,
      "errorsEmailAlreadyUsed": S.of(context).errorsEmailAlreadyUsed,
      "errorsIceAlreadyUsed": S.of(context).errorsIceAlreadyUsed,
      "errorsLegalNameAlreadyUsed": S.of(context).errorsLegalNameAlreadyUsed,
      "errorsInvalidCredentials": S.of(context).errorsInvalidCredentials,
      "errorsUserDisabled": S.of(context).errorsUserDisabled,
      "errorsInternal": S.of(context).errorsInternal,
      "errorsWeakPassword": S.of(context).authWeakPassword,
      "errorsSamePassword": S.of(context).errorsSamePassword,
      "errorsInvalidUserInfo": S.of(context).errorsInvalidUserInfo,
      "errorsNetwork": S.of(context).errorsNetwork,
      "errorsInvalidCurrentPassword": S.of(context).authInvalidCurrentPassword,
    };

    final message =
        (code != null && translations.containsKey(code))
            ? translations[code]!
            : fallback;

    final backgroundColor = isError ? AppColors.errorColor : Colors.green;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 4),
        ),
      );
  }
}
