import 'package:flutter/material.dart';

import 'package:e_facture/core/models/dashboard_stats_model.dart';
import 'package:e_facture/core/models/invoice_stat_model.dart';
import 'package:e_facture/core/models/user_status_model.dart';
import 'package:e_facture/core/models/user_adoption_model.dart';
import 'package:e_facture/core/services/admin_dashboard_service.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class AdminDashboardViewModel extends ChangeNotifier {
  final AdminDashboardService adminDashboardService;
  final AuthProvider authProvider;

  AdminDashboardViewModel({
    required this.adminDashboardService,
    required this.authProvider,
  });

  // Données
  DashboardStatsModel? stats;
  List<InvoiceStat> weeklyStats = [];
  List<InvoiceStat> monthlyStats = [];
  UserStatusStats? userStatus;
  UserAdoptionStats? userAdoption;

  // États
  bool isLoading = false;
  String? error;

  // Méthode principale
  Future<void> loadDashboard(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      // Appels en parallèle
      final results = await Future.wait([
        adminDashboardService.fetchDashboardStats(context),
        adminDashboardService.fetchWeeklyStats(context),
        adminDashboardService.fetchMonthlyStats(context),
        adminDashboardService.fetchUserStatusStats(context),
        adminDashboardService.fetchUserAdoptionStats(context),
      ]);

      stats = results[0] as DashboardStatsModel?;
      weeklyStats = results[1] as List<InvoiceStat>;
      monthlyStats = results[2] as List<InvoiceStat>;
      userStatus = results[3] as UserStatusStats?;
      userAdoption = results[4] as UserAdoptionStats?;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void refreshDashboard(BuildContext context) {
    loadDashboard(context);
  }

  bool get hasError => error != null;
}
