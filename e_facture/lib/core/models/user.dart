class User {
  final String id; // <-- Ajouté pour remplacer UserData
  final String email;
  final String ice;
  final String legalName;
  final String password;
  final bool isActive;
  final bool isFirstLogin;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id, // <-- Ajouté
    required this.email,
    required this.ice,
    required this.legalName,
    required this.password,
    required this.isActive,
    required this.isFirstLogin,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // <-- Ajouté
      'email': email,
      'ice': ice,
      'legalName': legalName,
      'password': password,
      'isActive': isActive,
      'isFirstLogin': isFirstLogin,
      'isAdmin': isAdmin,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    print("🧩 User.fromMap raw: $map"); // Temporaire pour debug

    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      ice: map['ice'] ?? '',
      legalName: map['legalName'] ?? '',
      password: map['password'] ?? '', // fallback vide
      isActive: map['isActive'] ?? true,
      isFirstLogin: map['isFirstLogin'] ?? true,
      isAdmin: map['isAdmin'] ?? false,
      createdAt:
          map['createdAt'] != null
              ? DateTime.parse(map['createdAt'])
              : DateTime.now(),
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.parse(map['updatedAt'])
              : DateTime.now(),
    );
  }
}
