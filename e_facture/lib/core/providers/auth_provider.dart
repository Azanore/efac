import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:e_facture/core/models/user.dart';
import 'package:e_facture/core/services/auth_service.dart';
import 'package:logger/logger.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();
  final Logger logger = Logger();

  User? _userData;
  String? _token;
  bool _isAuthenticated = false;

  // Getters
  User? get userData => _userData;
  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  bool get isFirstLogin => _userData?.isFirstLogin ?? false;

  Future<void> initAuth() async {
    final userJson = await _storage.read(key: 'user_data');
    final token = await _storage.read(key: 'auth_token');

    if (userJson != null && token != null) {
      _userData = User.fromMap(json.decode(userJson));
      _token = token;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final result = await _authService.login(email, password);

    logger.i("🧩 Login result in AuthProvider: $result");

    final bool success = result['success'] == true;
    final hasUser = result['user'] != null;
    final hasToken = result['token'] != null;

    if (success && hasUser && hasToken) {
      try {
        final user = User.fromMap(result['user']);
        final token = result['token'];

        logger.i("🧠 Parsed User in AuthProvider: ${user.toMap()}");

        await _storage.write(
          key: 'user_data',
          value: json.encode(user.toMap()),
        );
        await _storage.write(key: 'auth_token', value: token);

        _userData = user;
        _token = token;
        _isAuthenticated = true;

        notifyListeners();

        return {
          'success': true,
          'code': result['code'] ?? 'loginSuccess',
          'isFirstLogin': user.isFirstLogin,
        };
      } catch (e, stack) {
        logger.e(
          "❌ Error parsing user in AuthProvider",
          error: e,
          stackTrace: stack,
        );
        return {'success': false, 'code': 'errorsInternal'};
      }
    }

    if (success && (!hasUser || !hasToken)) {
      logger.w("⚠️ Login success but missing user or token");
      return {'success': false, 'code': 'errorsInvalidResponse'};
    }

    logger.w("⚠️ Login failed in AuthProvider: $result");
    return _authService.processApiResponse(result);
  }

  Future<Map<String, dynamic>> register(
    String email,
    String ice,
    String legalName,
  ) {
    return _authService.register(email, ice, legalName);
  }

  Future<Map<String, dynamic>> forgotPassword(
    String email,
    String ice,
    String legalName,
  ) {
    return _authService.forgotPassword(email, ice, legalName);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'user_data');
    await _storage.delete(key: 'auth_token');

    _userData = null;
    _token = null;
    _isAuthenticated = false;

    notifyListeners();
  }
  
}
