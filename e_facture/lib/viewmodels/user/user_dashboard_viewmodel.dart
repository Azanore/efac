import 'package:flutter/material.dart';

import '/core/models/user_stats_model.dart';
import '/core/services/user_stats_service.dart';
import '/core/providers/auth_provider.dart';

class UserDashboardViewModel extends ChangeNotifier {
  final UserStatsService userStatsService;
  final AuthProvider authProvider;

  UserDashboardViewModel({
    required this.userStatsService,
    required this.authProvider,
  });

  UserStatsModel? stats;
  bool isLoading = false;
  String? error;

  Future<void> loadStats(BuildContext context) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final user = authProvider.userData;
      final token = authProvider.token;

      if (user == null || token == null) {
        throw Exception("Utilisateur non authentifié");
      }

      final data = await userStatsService.fetchUserStats(user.id, token);
      stats = UserStatsModel.fromJson(data);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void refresh(BuildContext context) {
    loadStats(context);
  }

  bool get hasError => error != null;
}
