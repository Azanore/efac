import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '/core/utils/app_colors.dart';
import '/widgets/app_bar_widget.dart';
import '/widgets/drawer_widget.dart';
import '/widgets/custom_button_widget.dart';
import '/generated/l10n.dart';
import '/viewmodels/user/user_dashboard_viewmodel.dart';

class DashboardUser extends StatelessWidget {
  const DashboardUser({super.key});

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'fr_FR');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UserDashboardViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only attempt to load if the ViewModel's AuthProvider instance indicates
      // full authentication, and other conditions for loading are met.
      if (vm.authProvider.isAuthenticated &&
          vm.authProvider.userData != null &&
          vm.authProvider.token != null &&
          !vm.isLoading &&
          vm.stats == null &&
          !vm.hasError) {
        vm.loadStats(context);
      }
    });

    return Scaffold(
      appBar: AppBarWidget(title: S.of(context).navigationDashboardUser),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: AppColors.cardColor(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).statisticsTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor(context),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (vm.isLoading) // Check isLoading first and exclusively
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        else if (vm.hasError) // Then check for errors
                          Text(
                            //S.of(context).createInvoiceError(vm.error ?? S.of(context).errorsUnknown),
                            'Erreur de chargement des statistiques: ${vm.error}', // Consider a user-friendly message
                            style: TextStyle(color: AppColors.errorColor),
                          )
                        else if (vm.stats == null) // If not loading, no error, but stats are still null
                          Text(
                            "Aucune statistique disponible pour le moment.", // Placeholder - S.of(context).statisticsNoData
                            style: TextStyle(color: AppColors.textColor(context)),
                          )
                        else // Finally, display stats
                          Column(
                            children: [
                              _buildStatItem(
                                context: context,
                                title: S.of(context).invoiceCount,
                                value: '${vm.stats!.totalInvoices}',
                                icon: Icons.receipt,
                                color: AppColors.buttonColor,
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 12),
                              _buildStatItem(
                                context: context,
                                title: S.of(context).invoiceTotal,
                                value:
                                    '${_formatAmount(vm.stats!.totalAmount)} ${S.of(context).currencySymbol}',
                                icon: Icons.currency_exchange,
                                color: AppColors.successColor,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButtonWidget(
                  text: S.of(context).invoiceCreateInvoiceTitle,
                  onPressed:
                      () => Navigator.pushNamed(context, '/invoice/create'),
                  backgroundColor: AppColors.successColor,
                  textColor: AppColors.buttonTextColor,
                  icon: Icons.add_box,
                ),

                const SizedBox(height: 10),
                CustomButtonWidget(
                  text: S.of(context).dashboardViewMyInvoices,
                  onPressed:
                      () => Navigator.pushNamed(context, '/invoice/history'),
                  backgroundColor: AppColors.cardColor(context),
                  textColor: AppColors.textColor(context),
                  icon: Icons.history,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final textColor = AppColors.textColor(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha((0.1 * 255).round()),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withAlpha((0.8 * 255).round()),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
