import 'package:flutter/material.dart';
import 'package:e_facture/core/utils/app_colors.dart';

class DarkTheme {
  static final ThemeData data = ThemeData.dark().copyWith(
    primaryColor: AppColors.darkPrimaryColor,
    scaffoldBackgroundColor: AppColors.darkSecondaryColor,
    buttonTheme: ButtonThemeData(buttonColor: AppColors.buttonColor),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextColor,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: AppColors.darkTextColor,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.darkSecondaryColor,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextColor,
      ),
      contentTextStyle: TextStyle(fontSize: 16, color: AppColors.darkTextColor),
    ),
  );
}
