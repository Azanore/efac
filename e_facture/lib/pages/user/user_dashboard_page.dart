import 'package:e_facture/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import '/widgets/app_bar_widget.dart';
import '/widgets/drawer_widget.dart';
import '/widgets/custom_button_widget.dart';
import '/generated/l10n.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({super.key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  bool _statsFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_statsFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        if (mounted) {
          authProvider.fetchUserStats(context);
          setState(() {
            _statsFetched = true;
          });
        }
      });
    }
  }

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'fr_FR');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: S.of(context).navigationDashboardUser),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
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
                    padding: EdgeInsets.all(16),
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
                        SizedBox(height: 20),
                        Selector<
                          AuthProvider,
                          (bool, Map<String, dynamic>?, String?)
                        >(
                          selector:
                              (_, provider) => (
                                provider.isLoadingStats,
                                provider.userStats,
                                provider.statsError,
                              ),
                          builder: (ctx, statsData, _) {
                            final isLoading = statsData.$1;
                            final stats = statsData.$2;
                            final error = statsData.$3;

                            if (isLoading || stats == null) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColor,
                                ),
                              );
                            }

                            if (error != null) {
                              return Text(
                                'Error: $error',
                                style: TextStyle(color: AppColors.errorColor),
                              );
                            }

                            return Column(
                              children: [
                                _buildStatItem(
                                  title: S.of(context).invoiceCount,
                                  value: '${stats['totalInvoices']}',
                                  icon: Icons.receipt,
                                  color: AppColors.buttonColor,
                                  textColor: AppColors.textColor(context),
                                ),
                                SizedBox(height: 12),
                                Divider(height: 1),
                                SizedBox(height: 12),
                                _buildStatItem(
                                  title: S.of(context).invoiceTotal,
                                  value:
                                      '${_formatAmount(stats['totalAmount'])} ${S.of(context).currencySymbol}',
                                  icon: Icons.currency_exchange,
                                  color: AppColors.successColor,
                                  textColor: AppColors.textColor(context),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomButtonWidget(
                  text: S.of(context).invoiceCreateInvoiceTitle,
                  onPressed:
                      () => Navigator.pushNamed(context, '/invoice/create'),
                  backgroundColor: AppColors.successColor,
                  textColor: AppColors.buttonTextColor,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  icon: Icons.add_box,
                  height: 60,
                ),
                SizedBox(height: 10),
                CustomButtonWidget(
                  text: S.of(context).dashboardViewMyInvoices,
                  onPressed:
                      () => Navigator.pushNamed(context, '/invoice/history'),
                  backgroundColor: AppColors.primaryColor(context),
                  textColor: AppColors.buttonTextColor,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 4),
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
