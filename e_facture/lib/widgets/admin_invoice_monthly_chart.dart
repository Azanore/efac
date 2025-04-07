import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class AdminInvoiceMonthlyChart extends StatefulWidget {
  const AdminInvoiceMonthlyChart({super.key});

  @override
  State<AdminInvoiceMonthlyChart> createState() =>
      _AdminInvoiceMonthlyChartState();
}

class _AdminInvoiceMonthlyChartState extends State<AdminInvoiceMonthlyChart> {
  List<Map<String, dynamic>> stats = [];
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
      Uri.parse('$apiUrl/admin/invoices/monthly-stats'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rawStats = data['stats'] as List;

      final now = DateTime.now();
      final currentYear = now.year;

      final fullStats = List.generate(12, (index) {
        final month = index + 1;
        final key = "$currentYear-${month.toString().padLeft(2, '0')}";
        final found = rawStats.firstWhere(
          (e) => e['_id'] == key,
          orElse: () => {'_id': key, 'count': 0},
        );
        return {'month': key, 'count': found['count'] ?? 0};
      });
      if (!mounted) return; // Add this line

      setState(() {
        stats = fullStats;
        isLoading = false;
      });
    } else {
      if (!mounted) return; // Add this line

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final barColor = AppColors.iconColor(context).withOpacity(0.8);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // Utilisation de S.of(context) pour "Factures par Mois"
                          S
                              .of(context)
                              .monthly_invoice_title, // Utilisation de la clé de traduction
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: textColor.withOpacity(0.7),
                            ),
                            SizedBox(width: 5),
                            Text(
                              S
                                  .of(context)
                                  .current_year_label(DateTime.now().year),
                              style: TextStyle(
                                fontSize: 12,
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          borderData: FlBorderData(show: false),
                          barGroups:
                              stats.asMap().entries.map((entry) {
                                final index = entry.key;
                                final e = entry.value;
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: (e['count'] as num).toDouble(),
                                      color: barColor,
                                      width: 12,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                );
                              }).toList(),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, _) {
                                  final monthIndex = value.toInt();
                                  if (monthIndex < 0 || monthIndex > 11) {
                                    return Text('');
                                  }
                                  final label = DateFormat(
                                    'MMM',
                                  ).format(DateTime(0, monthIndex + 1));
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: textColor.withOpacity(0.7),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                getTitlesWidget:
                                    (value, _) => Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: textColor.withOpacity(0.7),
                                      ),
                                    ),
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
