import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import 'package:e_facture/core/services/invoice_service.dart';
import 'package:e_facture/core/providers/auth_provider.dart';
import 'package:e_facture/core/providers/user_provider.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/feedback_helper.dart';

class CreateInvoiceViewModel extends ChangeNotifier {
  final TextEditingController amountController = TextEditingController();

  File? selectedFile;
  String? selectedFileName;

  String? amountError;
  String? fileError;
  bool isLoading = false;

  // ========= VALIDATIONS =========

  String? validateAmount(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).errorsEmptyField;
    }

    try {
      final amount = double.parse(value.replaceAll(',', '.'));
      if (amount <= 5000000) {
        return S.of(context).invoiceAmountRequirements;
      }
    } catch (_) {
      return S.of(context).errorsInvalidAmountFormat;
    }

    return null;
  }

  String? validateFile(BuildContext context) {
    if (selectedFile == null) {
      return S.of(context).errorsEmptyField;
    }

    final extension = selectedFileName?.split('.').last.toLowerCase();
    if (extension != 'pdf') {
      return S.of(context).invoiceFileRequirements;
    }

    final fileSizeInMB = selectedFile!.lengthSync() / (1024 * 1024);
    if (fileSizeInMB > 2) {
      return S.of(context).invoiceFileRequirements;
    }

    return null;
  }

  // ========= PICKER =========

  Future<void> pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        selectedFile = File(result.files.single.path!);
        selectedFileName = result.files.single.name;
        fileError = null;

        // ✅ Afficher le succès ici
        FeedbackHelper.showFromCode(context, "fileSelected", isError: false);
      }

      notifyListeners();
    } catch (e) {
      fileError = e.toString();
      FeedbackHelper.showFromCode(context, "errorsFileSave"); // ou autre
      notifyListeners();
    }
  }

  // ========= SUBMIT =========

  Future<void> submitInvoice(BuildContext context) async {
    final amount = amountController.text.trim();
    final Logger logger = Logger();

    logger.i('🧾 Tentative de soumission de facture');
    logger.i('Montant saisi : $amount');
    logger.i('Fichier sélectionné : ${selectedFileName ?? "Aucun"}');

    amountError = validateAmount(context, amount);
    fileError = validateFile(context);

    if (amountError != null || fileError != null) {
      logger.w('❌ Erreurs de validation locale :');
      logger.w('amountError: $amountError');
      logger.w('fileError: $fileError');
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userData?.id;
      final token = authProvider.token;

      logger.i('🧪 Utilisateur : $userId');
      logger.i('🧪 Token présent : ${token != null}');

      if (userId == null || token == null) {
        logger.e('❌ Utilisateur ou token manquant');
        throw Exception(S.of(context).errorsLoginFailed);
      }

      final invoiceService = Provider.of<InvoiceService>(
        context,
        listen: false,
      );

      logger.i('📤 Envoi de la requête à invoiceService.createInvoice()...');

      final result = await invoiceService.createInvoice(
        context: context,
        userId: userId,
        amount: double.parse(amount.replaceAll(',', '.')),
        file: selectedFile!,
        fileName: selectedFileName!,
      );

      logger.i('✅ Réponse du backend : $result');

      if (result['success'] == true) {
        logger.i('🎉 Facture créée avec succès');

        // Refresh stats
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.fetchStats(userId, token);

        logger.i('📊 Statistiques utilisateur mises à jour');

        // Affichage feedback
        final code = result['code'];
        logger.i('🔁 Affichage feedback avec code: $code');

        FeedbackHelper.showFromCode(context, code, isError: false);

        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          logger.i('➡️ Redirection vers l’historique des factures');
          Navigator.pushReplacementNamed(context, '/invoice/history');
        }
      } else {
        logger.w('❌ Échec de création côté backend');
        logger.w('Détails erreur : ${result['message']}');

        final code = result['code'] ?? 'errorsInternal';
        logger.w('🔁 Affichage feedback erreur avec code : $code');

        FeedbackHelper.showFromCode(context, code, isError: true);
      }
    } catch (e, stacktrace) {
      logger.e(
        '💥 Exception attrapée dans submitInvoice()',
        error: e,
        stackTrace: stacktrace,
      );

      FeedbackHelper.showFromCode(context, null);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void disposeControllers() {
    amountController.dispose();
  }
}
