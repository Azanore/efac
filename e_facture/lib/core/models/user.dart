class User {
  final String email; // Email de l'utilisateur
  final String ice; // Identifiant fiscal de l'entreprise
  final String legalName; // Nom légal de l'entreprise (raison sociale)
  final String password; // Mot de passe crypté
  final bool isActive; // Indique si l'utilisateur est actif
  final bool isFirstLogin; // Indique si c'est le premier login de l'utilisateur
  final bool isAdmin; // Indique si l'utilisateur est un administrateur
  final DateTime createdAt; // Date de création du compte
  final DateTime updatedAt; // Date de la dernière mise à jour des informations

  User({
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

  // Méthode pour convertir un objet User en Map (utile pour l'API)
  Map<String, dynamic> toMap() {
    return {
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

  // Méthode pour créer un objet User à partir d'un Map (utile pour l'API)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      ice: map['ice'],
      legalName: map['legalName'],
      password: map['password'],
      isActive: map['isActive'] ?? true, // Valeur par défaut si manquante
      isFirstLogin:
          map['isFirstLogin'] ?? true, // Valeur par défaut si manquante
      isAdmin: map['isAdmin'] ?? false, // Valeur par défaut si manquante
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
