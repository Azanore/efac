import 'package:flutter/material.dart';
import 'package:e_facture/core/utils/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final Widget? leftAction;
  final Widget? rightAction;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;

  const AppBarWidget({
    super.key,
    required this.title,
    this.leftAction,
    this.rightAction,
    this.showBackButton = false,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Refined color logic for more appealing appearance
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final dynamicBackgroundColor =
        backgroundColor ??
        (isDarkMode
            ? AppColors.darkPrimaryColor
            : Color(
              0xFF2196F3,
            ) // A more vibrant, professional blue for light mode
            );

    final dynamicTitleColor =
        titleColor ??
        (isDarkMode
            ? AppColors.darkTextColor.withOpacity(0.95)
            : Colors
                .white // Crisp white for light mode
                );

    final dynamicIconColor =
        isDarkMode ? AppColors.darkIconColor : Colors.white;

    return AppBar(
      backgroundColor: dynamicBackgroundColor,
      iconTheme: IconThemeData(color: dynamicIconColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: dynamicTitleColor,
          letterSpacing: 1.2,
        ),
      ),
      leading:
          showBackButton
              ? IconButton(
                icon: Icon(Icons.arrow_back, color: dynamicIconColor),
                onPressed: () => Navigator.pop(context),
              )
              : leftAction,
      actions: [if (rightAction != null) rightAction!],
      elevation: elevation ?? 4.0,
      centerTitle: true,
    );
  }
}
