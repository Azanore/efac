import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/utils/app_colors.dart';
import '../core/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/generated/l10n.dart';

class AdminUserStatusChart extends StatefulWidget {
  const AdminUserStatusChart({super.key});

  @override
  State<AdminUserStatusChart> createState() => _AdminUserStatusChartState();
}

class _AdminUserStatusChartState extends State<AdminUserStatusChart> {
  int active = 0;
  int inactive = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final token = auth.token;
    final apiUrl = dotenv.env['API_URL']!;

    final response = await http.get(
      Uri.parse('$apiUrl/admin/users/status-stats'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        active = data['active'] ?? 0;
        inactive = data['inactive'] ?? 0;
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
    final total = active + inactive;
    final textColor = AppColors.textColor(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // Use the translated title here
                      S.of(context).user_status_chart_title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: [
                            PieChartSectionData(
                              value: active.toDouble(),
                              title:
                                  '${((active / total) * 100).toStringAsFixed(1)}%',
                              color: Colors.green,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            PieChartSectionData(
                              value: inactive.toDouble(),
                              title:
                                  '${((inactive / total) * 100).toStringAsFixed(1)}%',
                              color: Colors.red,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLegendItem(
                          S.of(context).active_label,
                          Colors.green,
                        ), // Use translated "Active" label
                        _buildLegendItem(
                          S.of(context).inactive_label,
                          Colors.red,
                        ), // Use translated "Inactive" label
                      ],
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textColor(context)),
        ),
      ],
    );
  }
}
