import 'package:flutter/material.dart';
import 'package:e_facture/core/services/user_stats_service.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? _userStats;
  bool _isLoadingStats = false;
  String? _statsError;

  Map<String, dynamic>? get userStats => _userStats;
  bool get isLoadingStats => _isLoadingStats;
  String? get statsError => _statsError;

  Future<void> fetchStats(String userId, String token) async {
    _isLoadingStats = true;
    _statsError = null;
    notifyListeners();

    try {
      final statsService = UserStatsService();
      final stats = await statsService.fetchUserStats(userId, token);
      _userStats = stats;
    } catch (e) {
      _statsError = e.toString();
    } finally {
      _isLoadingStats = false;
      notifyListeners();
    }
  }
}
