import 'package:flutter/material.dart';

class AppColors {
  // === LIGHT THEME COLORS ===
  static const lightPrimaryColor = Color(
    0xFF3498db,
  ); // Softer, more professional blue
  static const lightSecondaryColor = Color(
    0xFFF1F5F9,
  ); // Light slate background
  static const lightTextColor = Color(
    0xFF2C3E50,
  ); // Deep charcoal for better readability
  static const lightBackgroundColor = Color(
    0xFFFAFAFA,
  ); // Slightly softer off-white
  static const lightCardColor = Colors.white;
  static const lightBorderColor = Color(0xFFE2E8F0); // Soft, muted border
  static const lightIconColor = Color(
    0xFF2980b9,
  ); // Slightly deeper blue for icons

  // === DARK THEME COLORS ===
  static const darkPrimaryColor = Color(
    0xFF34495e,
  ); // Sophisticated dark blue-grey
  static const darkSecondaryColor = Color(0xFF1E2433); // Deep dark blue-black
  static const darkTextColor = Color(0xFFECF0F1); // Soft off-white for text
  static const darkBackgroundColor = Color(
    0xFF121721,
  ); // Deep navy-like background
  static const darkCardColor = Color(
    0xFF1E2D3E,
  ); // Slightly lighter than background
  static const darkBorderColor = Color(0xFF2C3E50); // Muted border color
  static const darkIconColor = Color(0xFF3498db); // Bright blue for contrast

  // === SHARED COLORS ===
  static const errorColor = Color(0xFFE74C3C); // Vibrant, clear red
  static const successColor = Color(0xFF2ECC71); // Bright, positive green
  static const warningColor = Color(
    0xFFF39C12,
  ); // Warm, attention-grabbing orange
  static const buttonColor = Color(0xFF3498db); // Consistent blue
  static const buttonTextColor = Colors.white;

  // === DYNAMIC GETTERS ===
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color primaryColor(BuildContext context) =>
      isDark(context) ? darkPrimaryColor : lightPrimaryColor;

  static Color secondaryColor(BuildContext context) =>
      isDark(context) ? darkSecondaryColor : lightSecondaryColor;

  static Color textColor(BuildContext context) =>
      isDark(context) ? darkTextColor : lightTextColor;

  static Color backgroundColor(BuildContext context) =>
      isDark(context) ? darkBackgroundColor : lightBackgroundColor;

  static Color cardColor(BuildContext context) =>
      isDark(context) ? darkCardColor : lightCardColor;

  static Color borderColor(BuildContext context) =>
      isDark(context) ? darkBorderColor : lightBorderColor;

  static Color iconColor(BuildContext context) =>
      isDark(context) ? darkIconColor : lightIconColor;

  static IconData themeModeIcon(BuildContext context) =>
      isDark(context) ? Icons.dark_mode : Icons.light_mode;
}
