class UserStatsModel {
  final int totalInvoices;
  final double totalAmount;

  UserStatsModel({
    required this.totalInvoices,
    required this.totalAmount,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      totalInvoices: json['totalInvoices'] ?? 0,
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
    );
  }
}
