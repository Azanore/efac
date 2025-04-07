import 'package:e_facture/viewmodels/user/create_invoice_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:e_facture/widgets/custom_button_widget.dart';
import 'package:e_facture/widgets/custom_text_field.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/app_colors.dart';

class CreateInvoice extends StatelessWidget {
  const CreateInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateInvoiceViewModel(),
      child: const CreateInvoiceContent(),
    );
  }
}

class CreateInvoiceContent extends StatelessWidget {
  const CreateInvoiceContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreateInvoiceViewModel>(context);
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
              const SizedBox(height: 20),

              CustomInputFieldWidget(
                label: S.of(context).generalAmount,
                hint: "5000001.00",
                controller: vm.amountController,
                icon: Icons.attach_money,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                errorText: vm.amountError,
              ),

              const SizedBox(height: 20),

              if (vm.selectedFileName != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "${S.of(context).generalFile}: ${vm.selectedFileName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fileNameTextColor,
                    ),
                  ),
                ),

              SizedBox(
                width: double.infinity,
                child: CustomButtonWidget(
                  text: S.of(context).invoiceAddPdf,
                  onPressed: () => vm.pickFile(context),
                  backgroundColor: AppColors.primaryColor(context),
                  textColor: AppColors.buttonTextColor,
                  icon: Icons.upload_file,
                ),
              ),

              if (vm.fileError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    vm.fileError!,
                    style: TextStyle(color: AppColors.errorColor),
                  ),
                ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: warningBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warningColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.warningColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        S.of(context).invoiceFileRequirements,
                        style: TextStyle(color: AppColors.warningColor),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: warningBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warningColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.warningColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        S.of(context).invoiceAmountRequirements,
                        style: TextStyle(color: AppColors.warningColor),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                    width: double.infinity,
                    child: CustomButtonWidget(
                      text: S.of(context).invoiceAddInvoice,
                      onPressed: () => vm.submitInvoice(context),
                      backgroundColor:
                          AppColors.successColor, // ✅ vert pour valider
                      textColor: AppColors.buttonTextColor,
                      icon: Icons.add_circle,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
