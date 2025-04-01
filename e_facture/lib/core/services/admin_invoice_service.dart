import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/invoice.dart';
import '../models/admin_invoice.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class AdminInvoiceService with ChangeNotifier {
  final String baseUrl = dotenv.get('API_URL');
  final Logger logger = Logger();

  List<Invoice> _invoices = [];
  List<AdminInvoice> _adminInvoices = [];
  bool _isLoading = false;
  String? _error;
  int _totalInvoices = 0;

  List<Invoice> get invoices => _invoices;
  List<AdminInvoice> get adminInvoices => _adminInvoices;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalInvoices => _totalInvoices;

  // Unifiée : Récupérer toutes les factures ou celles d'un utilisateur spécifique
  Future<void> fetchInvoices(
    BuildContext context,
    String? userId, {
    int limit = 10,
    int offset = 0,
    String? startDate,
    String? endDate,
    String? keyword,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) throw Exception('Token manquant');

      final queryParams = {'limit': '$limit', 'offset': '$offset'};
      if (startDate != null) queryParams['startDate'] = startDate;
      if (endDate != null) queryParams['endDate'] = endDate;
      if (keyword != null && keyword.isNotEmpty) {
        queryParams['keyword'] = keyword;
      }

      // Si `userId` est fourni, on récupère les factures pour cet utilisateur spécifique
      final uri = Uri.parse(
        (userId != null && userId.isNotEmpty)
            ? '$baseUrl/admin/users/$userId/invoices'
            : '$baseUrl/admin/invoices',
      ).replace(queryParameters: queryParams);

      logger.i('💡 📢 URL: $uri');
      logger.i('💡 📢 TOKEN: $token');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      logger.i('💡 📢 STATUS CODE: ${response.statusCode}');
      logger.i('💡 📢 RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final invoicesData = data['invoices'];

        if (offset == 0) _adminInvoices = [];

        final List<AdminInvoice> parsedInvoices =
            invoicesData
                .map<AdminInvoice>((item) => AdminInvoice.fromMap(item))
                .toList();

        _adminInvoices.addAll(parsedInvoices);
        _totalInvoices = data['totalInvoices'] ?? 0;
      } else {
        logger.e('Erreur récupération factures, code: ${response.statusCode}');
        throw Exception('Erreur récupération factures');
      }
    } catch (e) {
      logger.e('⛔ ⛔ Erreur fetchInvoices: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==== Helper : get token ====
  Future<String?> _getToken(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  // ==== Reset state ====
  void resetState() {
    _invoices = [];
    _isLoading = false;
    _error = null;
    _totalInvoices = 0;
    _adminInvoices = [];
    notifyListeners();
  }
}
