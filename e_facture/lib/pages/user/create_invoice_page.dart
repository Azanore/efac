import 'package:e_facture/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/services/invoice_service.dart';
import 'package:logger/logger.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class CreateInvoice extends StatefulWidget {
  const CreateInvoice({super.key});

  @override
  CreateInvoiceState createState() => CreateInvoiceState();
}

class CreateInvoiceState extends State<CreateInvoice> {
  final TextEditingController _amountController = TextEditingController();
  final logger = Logger();

  bool _isLoading = false;
  String? _errorMessage;
  String? _amountError;
  String? _fileError;

  File? _selectedFile;
  String? _selectedFileName;

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).errorsEmptyField;
    }

    try {
      final amount = double.parse(value.replaceAll(',', '.'));
      if (amount <= 5000000) {
        return S.of(context).invoiceAmountRequirements;
      }
    } catch (e) {
      return S.of(context).errorsInvalidEmail;
    }

    return null;
  }

  String? _validateFile() {
    if (_selectedFile == null) {
      return S.of(context).errorsEmptyField;
    }

    final extension = _selectedFileName?.split('.').last.toLowerCase();
    if (extension != 'pdf') {
      return S.of(context).invoiceFileRequirements;
    }

    final fileSizeInBytes = _selectedFile!.lengthSync();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    if (fileSizeInMB > 2) {
      return S.of(context).invoiceFileRequirements;
    }

    return null;
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _selectedFileName = result.files.single.name;
          _fileError = null;
        });

        if (!mounted) return;

        _showMessage(
          S.of(context).invoicePdfSelected(_selectedFileName!),
          isError: false,
        );
      }
    } catch (e) {
      setState(() {
        _fileError = e.toString();
      });

      if (!mounted) return;
      _showMessage(_fileError!, isError: true);
    }
  }

  Future<void> _addInvoice() async {
    final String amount = _amountController.text.trim();

    setState(() {
      _errorMessage = null;
      _amountError = null;
      _fileError = null;
    });

    _amountError = _validateAmount(amount);
    _fileError = _validateFile();

    if (_amountError != null || _fileError != null) {
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (!mounted) return;

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userData?.id;

      if (userId == null) {
        throw Exception(S.of(context).errorsLoginFailed);
      }

      final invoiceProvider = Provider.of<InvoiceService>(
        context,
        listen: false,
      );
      final result = await invoiceProvider.createInvoice(
        context: context,
        userId: userId,
        amount: double.parse(amount.replaceAll(',', '.')),
        file: _selectedFile!,
        fileName: _selectedFileName!,
      );

      if (result['success']) {
        logger.d("Résultat succès: $result");

        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.fetchStats(
          authProvider.userData!.id,
          authProvider.token!,
        );

        if (!mounted) return;

        _showMessage(result['message'], isError: false);

        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacementNamed(context, '/invoice/history');
      } else {
        setState(() {
          _errorMessage = result['message'];
        });

        _showMessage(_errorMessage!, isError: true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });

      if (!mounted) return;
      _showMessage(_errorMessage!, isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? AppColors.errorColor : AppColors.successColor,
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fileNameTextColor = AppColors.textColor(context);
    final warningBackgroundColor = AppColors.warningColor.withOpacity(
      Theme.of(context).brightness == Brightness.dark ? 0.15 : 0.1,
    );

    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).invoiceCreateInvoiceTitle,
        showBackButton: true,
        rightAction: QuickSettingsWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),

              CustomInputFieldWidget(
                label: S.of(context).generalAmount,
                hint: "5000001.00",
                controller: _amountController,
                icon: Icons.attach_money,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                errorText: _amountError,
              ),

              SizedBox(height: 20),

              if (_selectedFileName != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "${S.of(context).generalFile}: $_selectedFileName",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fileNameTextColor,
                    ),
                  ),
                ),

              CustomButtonWidget(
                text: S.of(context).invoiceAddPdf,
                onPressed: _pickFile,
                backgroundColor: AppColors.primaryColor(context),
                textColor: AppColors.buttonTextColor,
                icon: Icons.upload_file,
              ),

              if (_fileError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _fileError!,
                    style: TextStyle(color: AppColors.errorColor),
                  ),
                ),

              SizedBox(height: 8),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: warningBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warningColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.warningColor),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        S.of(context).invoiceFileRequirements,
                        style: TextStyle(color: AppColors.warningColor),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: warningBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warningColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.warningColor),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        S.of(context).invoiceAmountRequirements,
                        style: TextStyle(color: AppColors.warningColor),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomButtonWidget(
                    text: S.of(context).invoiceAddInvoice,
                    onPressed: _addInvoice,
                    backgroundColor: AppColors.buttonColor,
                    textColor: AppColors.buttonTextColor,
                    icon: Icons.add_circle,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
