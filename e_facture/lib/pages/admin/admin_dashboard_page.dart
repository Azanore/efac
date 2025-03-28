import 'package:flutter/material.dart';
import '/widgets/app_bar_widget.dart';
import '/widgets/drawer_widget.dart';
import '/widgets/custom_button_widget.dart';
import '/core/utils/app_colors.dart';
import '/generated/l10n.dart';
import '/widgets/admin_invoice_activity_chart.dart';
import '/widgets/admin_invoice_monthly_chart.dart';
import '/widgets/admin_user_status_chart.dart';
import '/widgets/admin_user_adoption_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '/core/services/auth_service.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int totalUsers = 0;
  int totalInvoices = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardStats();
  }

  Future<void> _fetchDashboardStats() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final token = auth.token;
    final apiUrl = dotenv.env['API_URL']!;

    final response = await http.get(
      Uri.parse('$apiUrl/admin/dashboard-stats'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        totalUsers = data['totalUsers'] ?? 0;
        totalInvoices = data['totalInvoices'] ?? 0;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: S.of(context).navigationDashboardAdmin),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // 📋 Carte des statistiques
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
                          S
                              .of(context)
                              .statisticsTitle, // Updated to use translation
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor(context),
                          ),
                        ),
                        SizedBox(height: 20),
                        if (!isLoading)
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatCard(
                                  context: context,
                                  title: S.of(context).adminTotalUsers,
                                  value: totalUsers.toString(),
                                  icon: Icons.people,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _buildStatCard(
                                  context: context,
                                  title: S.of(context).adminTotalInvoices,
                                  value: totalInvoices.toString(),
                                  icon: Icons.receipt_long,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // 👤 Gérer utilisateurs
                CustomButtonWidget(
                  text: S.of(context).adminManageUsers,
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/users');
                  },
                  backgroundColor: AppColors.buttonColor,
                  textColor: AppColors.buttonTextColor,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  icon: Icons.person_add,
                  height: 60,
                ),
                SizedBox(height: 10),

                // 🧾 Voir les factures
                CustomButtonWidget(
                  text: S.of(context).adminViewInvoices,
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin/invoices');
                  },
                  backgroundColor: AppColors.primaryColor(context),
                  textColor: AppColors.buttonTextColor,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  icon: Icons.history,
                  height: 60,
                ),

                SizedBox(height: 30),

                // 📊 Graphiques
                AdminInvoiceActivityChart(),
                SizedBox(height: 30),
                AdminInvoiceMonthlyChart(),
                SizedBox(height: 30),
                AdminUserStatusChart(),
                SizedBox(height: 30),
                AdminUserAdoptionChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final textColor = AppColors.textColor(context);

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
          ),
          SizedBox(height: 4),
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
