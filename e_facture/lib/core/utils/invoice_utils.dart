import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/core/services/invoice_service.dart';
import 'package:e_facture/core/models/invoice.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:open_file/open_file.dart';

class InvoiceUtils {
  static String formatAmount(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'fr_MA',
      symbol: 'MAD',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static Future<bool> requestPermissions(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // Store reference to ScaffoldMessenger before checking if context is still mounted
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Permission de stockage requise pour télécharger la facture.",
              ),
              backgroundColor: AppColors.errorColor,
              duration: Duration(seconds: 3),
            ),
          );
        }
        return false;
      }
    }
    return true;
  }

  static Future<void> handleDownload({
    required BuildContext context,
    required Invoice invoice,
    required ValueChanged<double> onProgress,
    required VoidCallback onStart,
    required Function(String message, bool success, String? path) onComplete,
  }) async {
    // Get service reference before any async operation
    final invoiceService = Provider.of<InvoiceService>(context, listen: false);

    final hasPermission = await requestPermissions(context);
    if (!hasPermission) return;

    onStart();

    try {
      final cancelToken = CancelToken();

      // Check if context is still valid before proceeding
      if (!context.mounted) {
        onComplete(
          "L'opération a été annulée car le contexte n'est plus valide",
          false,
          null,
        );
        return;
      }

      // Now we can safely use context since we've verified it's still mounted
      final result = await invoiceService.downloadInvoice(
        context,
        invoice.id!,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total);
          }
        },
        cancelToken: cancelToken,
      );

      onComplete(result['message'], result['success'], result['path']);

      if (result['success'] && result['path'] != null) {
        await OpenFile.open(result['path']);
      }
    } catch (e) {
      onComplete("Erreur lors du téléchargement", false, null);
    }
  }
}
