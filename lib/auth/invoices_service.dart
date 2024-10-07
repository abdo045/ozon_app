import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ozon/model/invoice_model.dart';

class InvoicesService {
  final String baseUrl = 'http://192.168.1.100:8080/api/employee'; // Replace with your API base URL

  Future<List<Invoice>> fetchDeliveryInvoices() async {
    final response = await http.get(Uri.parse('$baseUrl/invoices/taslem'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Invoice.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load invoices');
    }
  }
}

