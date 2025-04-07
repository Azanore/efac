class UserAdoptionStats {
  final int neverReturned;
  final int returnedButInactive;
  final int activeUsers;

  UserAdoptionStats({
    required this.neverReturned,
    required this.returnedButInactive,
    required this.activeUsers,
  });

  factory UserAdoptionStats.fromJson(Map<String, dynamic> json) {
    return UserAdoptionStats(
      neverReturned: json['neverReturned'] ?? 0,
      returnedButInactive: json['returnedButInactive'] ?? 0,
      activeUsers: json['activeUsers'] ?? 0,
    );
  }
}
