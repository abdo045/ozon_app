import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ozon/screen_receive/edit_invoices.dart';
import 'package:ozon/providers/invoices_provider.dart';

class DeliveryInvoices extends StatefulWidget {
  const DeliveryInvoices({super.key});

  @override
  State<DeliveryInvoices> createState() => _DeliveryInvoicesState();
}

class _DeliveryInvoicesState extends State<DeliveryInvoices> {
  bool isInvoiceCompleted = false;

  @override
  void initState() {
    super.initState();
    // Fetch the invoices using the provider when the widget initializes
    Provider.of<InvoicesProvider>(context, listen: false).fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    final invoicesProvider = Provider.of<InvoicesProvider>(context);
    final invoices = invoicesProvider.invoices;
    final isLoading = invoicesProvider.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          'تسليم',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {}, // يمكنك إضافة وظيفة البحث هنا
          icon: const Icon(Icons.search),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'تسليم / فواتير',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : invoices.isEmpty
                  ? const Center(child: Text('No invoices available'))
                  : Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text('عدد الفواتير : ${invoices.length}'),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: () {
                              invoicesProvider.fetchInvoices();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
                          0: FlexColumnWidth(0.2),
                          1: FlexColumnWidth(0.4),
                          2: FlexColumnWidth(0.4),
                          3: FlexColumnWidth(0.4),
                          4: FlexColumnWidth(0.6),
                        },
                        children: [
                          // Table Header
                          TableRow(children: [
                            tableCellHeader('اجراء'),
                            tableCellHeader('حالة'),
                            tableCellHeader('تفاصيل'),
                            tableCellHeader('التاريخ'),
                            tableCellHeader('الموقع'),
                          ]),
                          // Table Rows with Invoice Data
                          for (var invoice in invoices)
                            TableRow(children: [
                              Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: isInvoiceCompleted
                                        ? Colors.grey
                                        : Colors.green,
                                  ),
                                  onPressed: isInvoiceCompleted
                                      ? null
                                      : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditInvoices(
                                              invoiceCode: '',
                                              customerName: '',
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              tableCell(invoice.id as String),
                              tableCell(invoice.code),
                              tableCell(invoice.customerName),
                              tableCell(invoice.invoiceData), // Use the correct property for date
                              tableCell(invoice.location),
                            ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for creating table header cells
  Widget tableCellHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper method for creating table cells
  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
