import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/core/providers/theme_provider.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign; // Nouveau paramètre pour l'alignement

  const CustomTextWidget({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start, // Valeur par défaut : alignement à gauche
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Utilise le style personnalisé ou celui du thème
    TextStyle textStyle = style ?? themeProvider.themeData.textTheme.bodyLarge!;

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign, // Applique l'alignement
    );
  }
}
