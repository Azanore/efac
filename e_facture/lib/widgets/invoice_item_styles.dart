import 'package:flutter/material.dart';

class InvoiceItemStyles {
  static const double borderRadius = 12;
  static const EdgeInsets containerMargin = EdgeInsets.symmetric(
    vertical: 6,
    horizontal: 2,
  );
  static const EdgeInsets headerPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  );
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 10,
  );
  static const double iconSize = 16;
  static const double fileNameFontSize = 13;
  static const double amountFontSize = 14;
  static const double labelFontSize = 11;
  static const BoxShadow boxShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 4,
    offset: Offset(0, 2),
  );
}
