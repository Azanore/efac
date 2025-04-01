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

class AdminInvoiceActivityChart extends StatefulWidget {
  const AdminInvoiceActivityChart({super.key});

  @override
  State<AdminInvoiceActivityChart> createState() =>
      _AdminInvoiceActivityChartState();
}

class _AdminInvoiceActivityChartState extends State<AdminInvoiceActivityChart> {
  List<Map<String, dynamic>> stats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  // Helper function to convert DateTime to ISO 8601 format
  String formatDateToISO8601(DateTime date) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(date);
  }

  Future<void> _loadStats() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final token = auth.token;

    final apiUrl = dotenv.env['API_URL']!;
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 6));

    // Format the start and end dates to ISO 8601 format
    String startDateISO = formatDateToISO8601(sevenDaysAgo);
    String endDateISO = formatDateToISO8601(now);

    // Make the API request with the formatted dates
    final response = await http.get(
      Uri.parse(
        '$apiUrl/admin/invoices/weekly-stats?startDate=$startDateISO&endDate=$endDateISO',
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['stats'] == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final rawStats = data['stats'] as List;

      final fullStats = List.generate(7, (i) {
        final date = DateFormat(
          'yyyy-MM-dd',
        ).format(now.subtract(Duration(days: 6 - i)));

        // Convert the API date to Western numerals before comparison
        final westernDate = _convertArabicToWesternNumerals(date);

        final found = rawStats.firstWhere(
          (e) => _convertArabicToWesternNumerals(e['_id']) == westernDate,
          orElse: () => {'_id': date, 'count': 0},
        );

        return {'date': date, 'count': found['count'] ?? 0};
      });

      setState(() {
        stats = fullStats;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _convertArabicToWesternNumerals(String arabicDate) {
    final arabicNumerals = '٠١٢٣٤٥٦٧٨٩'; // Arabic numerals
    final westernNumerals = '0123456789'; // Western numerals

    // Replace Arabic numerals with Western numerals
    String westernDate = arabicDate
        .split('')
        .map((char) {
          final index = arabicNumerals.indexOf(char);
          return index != -1 ? westernNumerals[index] : char;
        })
        .join('');
    return westernDate;
  }

  @override
  Widget build(BuildContext context) {
    final barColor = AppColors.primaryColor(context).withOpacity(0.8);
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
                          // Utilisation de S.of(context) pour "Activité des Factures"
                          S
                              .of(context)
                              .invoice_activity_title, // Utilisation de la clé de traduction
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: textColor.withOpacity(0.7),
                            ),
                            SizedBox(width: 5),
                            Text(
                              // Utilisation de S.of(context) pour "7 derniers jours"
                              S.of(context).last_seven_days,
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
                                      width: 14,
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
                                  final day = stats[value.toInt()]['date'];
                                  final westernDate =
                                      _convertArabicToWesternNumerals(day);
                                  final label = DateFormat(
                                    'E',
                                  ).format(DateTime.parse(westernDate));
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
