import 'dart:convert';
import 'package:flutter/foundation.dart'; // pour compute
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class UserStatsService {
  final Logger logger = Logger();

  Future<Map<String, dynamic>> fetchUserStats(
    String userId,
    String token,
  ) async {
    final String baseUrl = dotenv.get('API_URL');
    final url = '$baseUrl/stats/$userId';

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      logger.i('📊 Fetching stats from: $url');

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = await compute(
          _parseJson,
          response.body,
        );

        if (jsonResponse['success'] == true) {
          return {
            'totalInvoices': jsonResponse['totalInvoices'] ?? 0,
            'totalAmount': (jsonResponse['totalAmount'] ?? 0).toDouble(),
          };
        } else {
          throw Exception(jsonResponse['message'] ?? 'Failed to fetch stats');
        }
      } else {
        throw Exception('Erreur HTTP: ${response.statusCode}');
      }
    } catch (e, stack) {
      logger.e("❌ fetchUserStats failed", error: e, stackTrace: stack);
      throw Exception('Erreur de récupération des stats');
    }
  }

  static Map<String, dynamic> _parseJson(String responseBody) {
    return json.decode(responseBody);
  }
}
