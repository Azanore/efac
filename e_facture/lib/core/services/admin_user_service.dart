import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class AdminUser {
  final String id;
  final String legalName;
  final String ice;
  final String email;
  final bool isActive;
  final int totalInvoices;
  final double totalAmount;

  AdminUser({
    required this.id,
    required this.legalName,
    required this.ice,
    required this.email,
    required this.isActive,
    required this.totalInvoices,
    required this.totalAmount,
  });

  factory AdminUser.fromMap(Map<String, dynamic> map) {
    return AdminUser(
      id: map['id'] ?? '',
      legalName: map['legalName'] ?? '',
      ice: map['ice'] ?? '',
      email: map['email'] ?? '',
      isActive: map['isActive'] ?? true,
      totalInvoices: map['totalInvoices'] ?? 0,
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
    );
  }
}

class AdminUserService with ChangeNotifier {
  final String baseUrl = '${dotenv.get('API_URL')}/admin/users';
  final Logger logger = Logger();

  List<AdminUser> _users = [];
  bool _isLoading = false;
  String? _error;
  int _totalUsers = 0;
  String? _searchKeyword;

  List<AdminUser> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalUsers => _totalUsers;
  String? get searchKeyword => _searchKeyword;

  Future<void> fetchUsers(
    BuildContext context, {
    int limit = 10,
    int offset = 0,
    bool? isActive,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      logger.d('📢 TOKEN: $token');

      // Construction correcte des paramètres de requête
      final Map<String, String> queryParams = {
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      if (isActive != null) {
        queryParams['isActive'] = isActive.toString();
      }

      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

      logger.d('📢 URL: $uri');

      if (token == null) throw Exception('Token introuvable');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      logger.d('📢 STATUS CODE: ${response.statusCode}');
      logger.d('📢 BODY: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> usersData = data['users'];

        if (offset == 0) _users = [];

        _users.addAll(
          usersData.map((item) => AdminUser.fromMap(item)).toList(),
        );

        _totalUsers = data['totalUsers'] ?? 0;
      } else {
        throw Exception('Erreur récupération des utilisateurs');
      }
    } catch (e) {
      logger.e('⛔ Erreur fetchUsers: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchUsers(
    BuildContext context, {
    required String keyword,
    int limit = 10,
    int offset = 0,
    bool? isActive, // Ajouter ce paramètre
  }) async {
    _isLoading = true;
    _error = null;
    _searchKeyword = keyword;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) throw Exception('Token introuvable');

      final queryParams = {
        'keyword': keyword,
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      if (isActive != null) {
        queryParams['isActive'] = isActive.toString();
      }

      final uri = Uri.parse(
        '$baseUrl/search',
      ).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> usersData = data['users'];

        if (offset == 0) _users = [];

        _users.addAll(
          usersData.map((item) => AdminUser.fromMap(item)).toList(),
        );

        _totalUsers = data['totalUsers'] ?? 0;
      } else {
        throw Exception('Erreur recherche des utilisateurs');
      }
    } catch (e) {
      logger.e('⛔ Erreur searchUsers: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleUserStatus(
    BuildContext context,
    String userId,
    bool isActive,
  ) async {
    try {
      final token = await _getToken(context);
      if (token == null) throw Exception('Non authentifié');

      final response = await http.put(
        Uri.parse('$baseUrl/$userId/disable'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'isActive': isActive}),
      );

      if (response.statusCode != 200) {
        throw Exception('Erreur lors de la mise à jour du statut');
      }

      // Mise à jour locale
      final index = _users.indexWhere((user) => user.id == userId);
      if (index != -1) {
        _users[index] = AdminUser(
          id: _users[index].id,
          legalName: _users[index].legalName,
          ice: _users[index].ice,
          email: _users[index].email,
          isActive: isActive,
          totalInvoices: _users[index].totalInvoices,
          totalAmount: _users[index].totalAmount,
        );
        notifyListeners();
      }
    } catch (e) {
      logger.e('Erreur toggleUserStatus: $e');
      throw Exception(e.toString());
    }
  }

  Future<String?> _getToken(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  void resetState() {
    _users = [];
    _isLoading = false;
    _error = null;
    _searchKeyword = null;
    notifyListeners();
  }
}
