import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import '../models/dashboard_stats_model.dart';
import '../models/invoice_stat_model.dart';
import '../models/user_status_model.dart';
import '../models/user_adoption_model.dart';
import '../providers/auth_provider.dart';

class AdminDashboardService {
  final Logger logger = Logger();
  final String baseUrl = dotenv.get('API_URL');

  Future<String?> _getToken(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  Future<DashboardStatsModel?> fetchDashboardStats(BuildContext context) async {
    try {
      final token = await _getToken(context);
      final url = Uri.parse('$baseUrl/admin/dashboard-stats');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      logger.i('📊 [DashboardStats] ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DashboardStatsModel.fromJson(data);
      } else {
        throw Exception('Erreur dashboard-stats');
      }
    } catch (e) {
      logger.e('⛔ fetchDashboardStats: $e');
      return null;
    }
  }

  Future<List<InvoiceStat>> fetchWeeklyStats(BuildContext context) async {
    return _fetchInvoiceStats(context, '$baseUrl/admin/invoices/weekly-stats');
  }

  Future<List<InvoiceStat>> fetchMonthlyStats(BuildContext context) async {
    return _fetchInvoiceStats(context, '$baseUrl/admin/invoices/monthly-stats');
  }

  Future<List<InvoiceStat>> _fetchInvoiceStats(
    BuildContext context,
    String urlStr,
  ) async {
    try {
      final token = await _getToken(context);
      final url = Uri.parse(urlStr);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      logger.i('📈 [InvoiceStats] $urlStr → ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stats = data['stats'] as List<dynamic>;
        return stats.map((e) => InvoiceStat.fromJson(e)).toList();
      } else {
        throw Exception('Erreur invoice-stats');
      }
    } catch (e) {
      logger.e('⛔ _fetchInvoiceStats: $e');
      return [];
    }
  }

  Future<UserStatusStats?> fetchUserStatusStats(BuildContext context) async {
    try {
      final token = await _getToken(context);
      final url = Uri.parse('$baseUrl/admin/users/status-stats');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      logger.i('👥 [UserStatusStats] ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserStatusStats.fromJson(data);
      } else {
        throw Exception('Erreur user-status-stats');
      }
    } catch (e) {
      logger.e('⛔ fetchUserStatusStats: $e');
      return null;
    }
  }

  Future<UserAdoptionStats?> fetchUserAdoptionStats(
    BuildContext context,
  ) async {
    try {
      final token = await _getToken(context);
      final url = Uri.parse('$baseUrl/admin/users/adoption-stats');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      logger.i('📊 [UserAdoptionStats] ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserAdoptionStats.fromJson(data);
      } else {
        throw Exception('Erreur user-adoption-stats');
      }
    } catch (e) {
      logger.e('⛔ fetchUserAdoptionStats: $e');
      return null;
    }
  }
}
