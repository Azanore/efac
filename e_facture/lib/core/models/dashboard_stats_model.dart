class DashboardStatsModel {
  final int totalUsers;
  final int totalInvoices;

  DashboardStatsModel({required this.totalUsers, required this.totalInvoices});

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalUsers: json['totalUsers'] ?? 0,
      totalInvoices: json['totalInvoices'] ?? 0,
    );
  }
}
