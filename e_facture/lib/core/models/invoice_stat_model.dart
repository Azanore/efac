class InvoiceStat {
  final String date;
  final int count;

  InvoiceStat({
    required this.date,
    required this.count,
  });

  factory InvoiceStat.fromJson(Map<String, dynamic> json) {
    return InvoiceStat(
      date: json['_id'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}
