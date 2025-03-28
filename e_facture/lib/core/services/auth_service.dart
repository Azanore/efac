import 'package:flutter/foundation.dart'; // Nécessaire pour compute()
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserData {
  final String id;
  final String email;
  final String legalName;
  final String ice;
  final bool isAdmin;
  final bool isFirstLogin;

  UserData({
    required this.id,
    required this.email,
    required this.legalName,
    required this.ice,
    required this.isAdmin,
    required this.isFirstLogin,
  });

  // Convertir JSON en objet UserData
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      legalName: json['legalName'] ?? '',
      ice: json['ice'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      isFirstLogin: json['isFirstLogin'] ?? true,
    );
  }

  // Convertir objet UserData en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'legalName': legalName,
      'ice': ice,
      'isAdmin': isAdmin,
      'isFirstLogin': isFirstLogin,
    };
  }
}

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  UserData? _userData;
  String? _token;
  bool _isAuthenticated = false;

  var logger = Logger();

  // Variables pour les statistiques utilisateur
  Map<String, dynamic>? _userStats;
  bool _isLoadingStats = false;
  String? _statsError;

  // Getters
  UserData? get userData => _userData;
  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  bool get isFirstLogin => _userData?.isFirstLogin ?? false;
  Map<String, dynamic>? get userStats => _userStats;
  bool get isLoadingStats => _isLoadingStats;
  String? get statsError => _statsError;

  // Initialiser l'état d'authentification au démarrage
  Future<void> initAuth() async {
    final userJson = await _storage.read(key: 'user_data');
    final token = await _storage.read(key: 'auth_token');
    logger.i('Stored Token: $token');
    if (userJson != null && token != null) {
      _userData = UserData.fromJson(json.decode(userJson));
      _token = token;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  // Connexion utilisateur
  Future<Map<String, dynamic>> login(String email, String password) async {
    final String baseUrl = dotenv.get('API_URL');
    final String authPath = dotenv.get('AUTH_PATH');
    final url = Uri.parse('$baseUrl$authPath/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        // Stocker les données utilisateur et le token
        final userData = UserData.fromJson(responseData['user']);
        final token = responseData['token'];

        await _storage.write(
          key: 'user_data',
          value: json.encode(userData.toJson()),
        );
        await _storage.write(key: 'auth_token', value: token);
        _userData = userData;
        _token = token;
        _isAuthenticated = true;

        notifyListeners();

        return {
          'success': true,
          'message': responseData['message'],
          'isFirstLogin': userData.isFirstLogin,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Une erreur est survenue.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur de connexion: ${e.toString()}',
      };
    }
  }

  // Déconnexion utilisateur
  Future<void> logout() async {
    await _storage.delete(key: 'user_data');
    await _storage.delete(key: 'auth_token');

    _userData = null;
    _token = null;
    _isAuthenticated = false;
    _userStats = null;
    _statsError = null;

    notifyListeners();
  }

  // Récupérer les statistiques de l'utilisateur avec FutureBuilder
  Future<Map<String, dynamic>> fetchUserStats(BuildContext context) async {
    if (_userData == null || _userData!.id.isEmpty) {
      throw Exception('User not authenticated');
    }

    _isLoadingStats = true;
    _statsError = null;
    notifyListeners();

    final String baseUrl = dotenv.get('API_URL');
    final String url = '$baseUrl/stats/${_userData!.id}';

    try {
      final response = await authenticatedRequest(url, 'GET');
      if (response.statusCode == 200) {
        final jsonResponse = await compute(_parseJson, response.body);

        if (jsonResponse['success'] == true) {
          _userStats = {
            'totalInvoices': jsonResponse['totalInvoices'] ?? 0,
            'totalAmount': (jsonResponse['totalAmount'] ?? 0).toDouble(),
          };
        } else {
          _statsError = jsonResponse['message'] ?? 'Failed to fetch stats';
        }
      } else {
        _statsError =
            'Failed to fetch stats. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _statsError = e.toString();
    } finally {
      _isLoadingStats = false;
      notifyListeners();
    }

    if (_statsError != null) {
      throw Exception(_statsError);
    }

    return _userStats!;
  }

  // Utiliser compute pour analyser les données JSON
  static Map<String, dynamic> _parseJson(String responseBody) {
    return json.decode(responseBody);
  }

  // Effectuer une requête HTTP authentifiée
  Future<http.Response> authenticatedRequest(
    String url,
    String method, {
    Map<String, dynamic>? body,
  }) async {
    if (_token == null) {
      throw Exception('Non authentifié');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    logger.i('Sending request to $url with token: $_token');

    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(Uri.parse(url), headers: headers);
      case 'POST':
        return await http.post(
          Uri.parse(url),
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      case 'PUT':
        return await http.put(
          Uri.parse(url),
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      case 'DELETE':
        return await http.delete(Uri.parse(url), headers: headers);
      default:
        throw Exception('Méthode HTTP non supportée');
    }
  }
}
