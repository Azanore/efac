import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class AuthService {
  final Logger logger = Logger();

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
      logger.i("📬 Raw login response: ${responseData.toString()}");

      if (response.statusCode == 200 && responseData['success'] == true) {
        logger.i("🎯 Login success – received user and token");

        final result = processApiResponse(responseData);

        // 🧩 Ajoute les champs que AuthProvider attend
        result['user'] = responseData['user'];
        result['token'] = responseData['token'];

        logger.i("✅ Final processed login result: $result");

        return result;
      } else {
        logger.w(
          "⚠️ Login failed – status: ${response.statusCode}, body: ${response.body}",
        );
        return processApiResponse(responseData);
      }
    } catch (e, stack) {
      logger.e("❌ Exception during login", error: e, stackTrace: stack);
      return {'success': false, 'code': 'errorsNetwork'};
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String ice,
    String legalName,
  ) async {
    final String baseUrl = dotenv.get('API_URL');
    final String authPath = dotenv.get('AUTH_PATH');
    final url = Uri.parse('$baseUrl$authPath/register');

    try {
      logger.i("📤 Sending register request...");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'ice': ice, 'legalName': legalName}),
      );

      final responseData = json.decode(response.body);
      logger.i("📬 Raw registration response: $responseData");

      return responseData;
    } catch (e, stack) {
      logger.e("❌ Exception during registration", error: e, stackTrace: stack);
      return {'success': false, 'code': 'errorsNetwork'};
    }
  }

  Future<Map<String, dynamic>> forgotPassword(
    String email,
    String ice,
    String legalName,
  ) async {
    final String baseUrl = dotenv.get('API_URL');
    final String authPath = dotenv.get('AUTH_PATH');
    final url = Uri.parse('$baseUrl$authPath/forgot-password');

    try {
      logger.i("📤 Sending forgot password request...");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'ice': ice, 'legalName': legalName}),
      );

      final responseData = json.decode(response.body);
      logger.i("📬 Raw forgot password response: $responseData");

      return responseData;
    } catch (e, stack) {
      logger.e(
        "❌ Exception during forgot password",
        error: e,
        stackTrace: stack,
      );
      return {'success': false, 'code': 'errorsNetwork'};
    }
  }

  Future<http.Response> authenticatedRequest(
    String url,
    String method, {
    Map<String, dynamic>? body,
    required String token,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    logger.i('Sending request to $url with token: $token');

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

  Map<String, dynamic> processApiResponse(dynamic responseData) {
    final bool success = responseData['success'] == true;
    final String? code = responseData['code']?.toString().trim();

    return {
      'success': success,
      'code': code ?? (success ? 'genericSuccess' : 'errorsInternal'),
    };
  }

  static Map<String, dynamic> parseJson(String responseBody) {
    return json.decode(responseBody);
  }
}
