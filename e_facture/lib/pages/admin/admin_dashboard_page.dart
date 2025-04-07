import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/utils/app_colors.dart';
import '/widgets/app_bar_widget.dart';
import '/widgets/drawer_widget.dart';
import '/widgets/custom_button_widget.dart';
import '/widgets/admin_invoice_activity_chart.dart';
import '/widgets/admin_invoice_monthly_chart.dart';
import '/widgets/admin_user_status_chart.dart';
import '/widgets/admin_user_adoption_chart.dart';
import '/generated/l10n.dart';

import '/viewmodels/admin/admin_dashboard_viewmodel.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AdminDashboardViewModel>();

    // si besoin de lancer le chargement :
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!vm.isLoading && vm.stats == null) {
        vm.loadDashboard(context);
      }
    });

    return const _DashboardView();
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AdminDashboardViewModel>();

    return Scaffold(
      appBar: AppBarWidget(title: S.of(context).navigationDashboardAdmin),
      drawer: const DrawerWidget(),
      body:
          vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : vm.hasError
              ? Center(
                child: Text(
                  "❌ ${vm.error}",
                  style: TextStyle(color: AppColors.errorColor, fontSize: 16),
                ),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildStatsCard(context, vm),
                        const SizedBox(height: 30),
                        _buildButtons(context),
                        const SizedBox(height: 30),
                        const AdminInvoiceActivityChart(),
                        const SizedBox(height: 30),
                        const AdminInvoiceMonthlyChart(),
                        const SizedBox(height: 30),
                        const AdminUserStatusChart(),
                        const SizedBox(height: 30),
                        const AdminUserAdoptionChart(),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  Widget _buildStatsCard(BuildContext context, AdminDashboardViewModel vm) {
    final stats = vm.stats;
    if (stats == null) return const SizedBox();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: S.of(context).adminTotalUsers,
                    value: stats.totalUsers.toString(),
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: S.of(context).adminTotalInvoices,
                    value: stats.totalInvoices.toString(),
                    icon: Icons.receipt_long,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButtonWidget(
          text: S.of(context).adminManageUsers,
          onPressed: () => Navigator.pushNamed(context, '/admin/users'),
          backgroundColor: AppColors.buttonColor,
          textColor: AppColors.buttonTextColor,
          icon: Icons.person_add,
        ),
        const SizedBox(height: 10),
        CustomButtonWidget(
          text: S.of(context).adminViewInvoices,
          onPressed: () => Navigator.pushNamed(context, '/admin/invoices'),
          backgroundColor: AppColors.cardColor(context),
          textColor: AppColors.textColor(context),
          icon: Icons.history,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final textColor = AppColors.textColor(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
