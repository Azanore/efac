class Invoice {
  final String? id; // Nullable pour la création
  final String userId;
  final String fileName;
  final String fileUrl;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Invoice({
    this.id,
    required this.userId,
    required this.fileName,
    required this.fileUrl,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  // Méthode pour convertir un objet Invoice en Map
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'userId': userId,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'amount': amount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };

    // Ajout conditionnel de l'ID
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  // Factory pour créer un objet depuis un Map
  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['_id'] ?? map['id'],
      userId: map['userId'] ?? '',
      fileName: map['fileName'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
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
