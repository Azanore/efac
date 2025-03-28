import 'package:flutter/material.dart';
import 'package:e_facture/core/utils/app_colors.dart';

class LightTheme {
  static final ThemeData data = ThemeData.light().copyWith(
    primaryColor: AppColors.lightPrimaryColor,
    scaffoldBackgroundColor: AppColors.lightSecondaryColor,
    buttonTheme: ButtonThemeData(buttonColor: AppColors.buttonColor),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: AppColors.lightTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextColor,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: AppColors.lightTextColor,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.lightSecondaryColor,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextColor,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16,
        color: AppColors.lightTextColor,
      ),
    ),
  );
}
