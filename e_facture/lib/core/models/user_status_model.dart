class UserStatusStats {
  final int active;
  final int inactive;

  UserStatusStats({
    required this.active,
    required this.inactive,
  });

  factory UserStatusStats.fromJson(Map<String, dynamic> json) {
    return UserStatusStats(
      active: json['active'] ?? 0,
      inactive: json['inactive'] ?? 0,
    );
  }
}
