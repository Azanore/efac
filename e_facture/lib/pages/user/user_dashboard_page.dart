import 'package:flutter/material.dart';
import '/widgets/app_bar_widget.dart';
import '/widgets/drawer_widget.dart';
import '/widgets/custom_button_widget.dart';
import '/generated/l10n.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:e_facture/core/providers/auth_provider.dart';
import 'package:e_facture/core/providers/user_provider.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({super.key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasFetched) {
      _hasFetched = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.fetchStats(authProvider.userData!.id, authProvider.token!);
      });
    }
  }

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'fr_FR');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final stats = userProvider.userStats;
    final isLoading = userProvider.isLoadingStats;
    final error = userProvider.statsError;

    return Scaffold(
      appBar: AppBarWidget(title: S.of(context).navigationDashboardUser),
      drawer: DrawerWidget(),
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
                        if (isLoading || stats == null)
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        else if (error != null)
                          Text(
                            'Erreur : $error',
                            style: TextStyle(color: AppColors.errorColor),
                          )
                        else
                          Column(
                            children: [
                              _buildStatItem(
                                title: S.of(context).invoiceCount,
                                value: '${stats['totalInvoices']}',
                                icon: Icons.receipt,
                                color: AppColors.buttonColor,
                                textColor: AppColors.textColor(context),
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 12),
                              _buildStatItem(
                                title: S.of(context).invoiceTotal,
                                value:
                                    '${_formatAmount(stats['totalAmount'])} ${S.of(context).currencySymbol}',
                                icon: Icons.currency_exchange,
                                color: AppColors.successColor,
                                textColor: AppColors.textColor(context),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  icon: Icons.add_box,
                  height: 60,
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                  text: S.of(context).dashboardViewMyInvoices,
                  onPressed:
                      () => Navigator.pushNamed(context, '/invoice/history'),
                  backgroundColor: AppColors.primaryColor(context),
                  textColor: AppColors.buttonTextColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  icon: Icons.history,
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color textColor,
  }) {
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
