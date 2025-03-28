import 'invoice.dart';

class AdminInvoice {
  final Invoice invoice;
  final String? userLegalName;
  final String? userEmail;
  final String? userIce;

  AdminInvoice({
    required this.invoice,
    this.userLegalName,
    this.userEmail,
    this.userIce,
  });

  factory AdminInvoice.fromMap(Map<String, dynamic> map) {
    final invoice = Invoice.fromMap({
      ...map,
      'userId': map['userId']?['_id'] ?? '',
    });

    String? legalName;
    String? email;
    String? ice;
    if (map['userId'] != null) {
      legalName = map['userId']['legalName'];
      email = map['userId']['email'];
      ice = map['userId']['ice'];
    }

    return AdminInvoice(
      invoice: invoice,
      userLegalName: legalName,
      userEmail: email,
      userIce: ice,
    );
  }
}
