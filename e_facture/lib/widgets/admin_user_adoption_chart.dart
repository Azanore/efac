import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/utils/app_colors.dart';
import '../core/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/generated/l10n.dart';

class AdminUserAdoptionChart extends StatefulWidget {
  const AdminUserAdoptionChart({super.key});

  @override
  State<AdminUserAdoptionChart> createState() => _AdminUserAdoptionChartState();
}

class _AdminUserAdoptionChartState extends State<AdminUserAdoptionChart> {
  int neverReturned = 0;
  int returnedButInactive = 0;
  int activeUsers = 0;
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
      Uri.parse('$apiUrl/admin/users/adoption-stats'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        neverReturned = data['neverReturned'] ?? 0;
        returnedButInactive = data['returnedButInactive'] ?? 0;
        activeUsers = data['activeUsers'] ?? 0;
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
    final total = neverReturned + returnedButInactive + activeUsers;
    final textColor = AppColors.textColor(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : total == 0
                ? Center(
                  child: Text(
                    S
                        .of(context)
                        .no_data_message, // Use translated "No data to display"
                    style: TextStyle(color: textColor),
                  ),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).adoption_rate_title, // Use translated title
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
                              value: neverReturned.toDouble(),
                              title:
                                  '${((neverReturned / total) * 100).toStringAsFixed(1)}%',
                              color: Colors.grey,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            PieChartSectionData(
                              value: returnedButInactive.toDouble(),
                              title:
                                  '${((returnedButInactive / total) * 100).toStringAsFixed(1)}%',
                              color: Colors.orange,
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            PieChartSectionData(
                              value: activeUsers.toDouble(),
                              title:
                                  '${((activeUsers / total) * 100).toStringAsFixed(1)}%',
                              color: Colors.green,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem(
                          S
                              .of(context)
                              .never_returned_label, // Use translated label
                          Colors.grey,
                        ),
                        SizedBox(height: 6),
                        _buildLegendItem(
                          S
                              .of(context)
                              .returned_without_invoice_label, // Use translated label
                          Colors.orange,
                        ),
                        SizedBox(height: 6),
                        _buildLegendItem(
                          S
                              .of(context)
                              .returned_and_invoiced_label, // Use translated label
                          Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
