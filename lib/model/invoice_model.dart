class Invoice {
  final int id;
  final String code;
  final String invoiceData;
  final String customerName;
  final String location;

  Invoice({
    required this.id,
    required this.code,
    required this.invoiceData,
    required this.customerName,
    required this.location,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      code: json['code'],
      invoiceData: json['invoice_data'],
      customerName: json['customer_name'],
      location: json['location'],
    );
  }
}
