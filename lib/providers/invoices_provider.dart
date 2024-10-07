import 'package:flutter/material.dart';
import 'package:ozon/auth/invoices_service.dart';
import 'package:ozon/model/invoice_model.dart';

class InvoicesProvider with ChangeNotifier {
  final InvoicesService _invoicesService = InvoicesService();
  List<Invoice> _invoices = [];
  bool _isLoading = true;

  List<Invoice> get invoices => _invoices;
  bool get isLoading => _isLoading;

  Future<void> fetchInvoices() async {
    _isLoading = true; // Start loading
    notifyListeners();

    try {
      _invoices = await _invoicesService.fetchDeliveryInvoices();
    } catch (error) {
      // Handle error (optional)
    } finally {
      _isLoading = false; // Stop loading
      notifyListeners();
    }
  }
}
