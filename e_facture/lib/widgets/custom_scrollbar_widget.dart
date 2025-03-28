import 'package:flutter/material.dart';
import 'package:e_facture/core/utils/app_colors.dart';

class CustomScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController controller;

  const CustomScrollbar({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final thumbColor =
        isDarkMode
            ? AppColors.lightPrimaryColor.withAlpha((255 * 0.7).toInt())
            : AppColors.lightPrimaryColor.withAlpha((255 * 0.6).toInt());

    return RawScrollbar(
      controller: controller,
      thumbVisibility: true,
      radius: const Radius.circular(8),
      thickness: 4, // scrollbar fine
      thumbColor: thumbColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 8), // pour ne pas coller au bord
        child: child,
      ),
    );
  }
}
