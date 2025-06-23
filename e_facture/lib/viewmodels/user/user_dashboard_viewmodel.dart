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
    // Enhanced check for authentication status
    if (!authProvider.isAuthenticated || authProvider.userData == null || authProvider.token == null) {
      error = "Utilisateur non authentifié ou données utilisateur non disponibles.";
      stats = null; // Ensure stats are also null
      isLoading = false; // Ensure loading stops
      notifyListeners();
      return; // Don't proceed if not authenticated
    }

    isLoading = true;
    error = null;
    // stats = null; // Optionally clear previous stats before loading new ones if desired
    notifyListeners();

    try {
      // At this point, we are more confident that user and token are available
      final user = authProvider.userData!; // Can use ! due to the check above
      final token = authProvider.token!;   // Can use ! due to the check above

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

  void clearStats() {
    stats = null;
    isLoading = false;
    error = null;
    notifyListeners();
  }
}
