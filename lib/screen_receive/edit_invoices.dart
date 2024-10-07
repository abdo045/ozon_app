import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ozon/screen_receive/Ozon_Home.dart';

class EditInvoices extends StatefulWidget {
  final String invoiceCode; // إضافة متغير لرقم الفاتورة
  final String customerName; // إضافة متغير لاسم العميل

  EditInvoices({required this.invoiceCode, required this.customerName}); // تمرير المتغيرات عبر الباني

  @override
  _EditInvoicesState createState() => _EditInvoicesState();
}

class _EditInvoicesState extends State<EditInvoices> {
  TextEditingController serialController = TextEditingController();
  List<String> serials = [];

  // Function to add serial to the list
  void addSerial(String serial) {
    if (serial.isNotEmpty) {
      setState(() {
        serials.add(serial);
        serialController.clear();
      });
    }
  }

  // Function to scan barcode or QR code
  Future<void> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Color of the cancel button
        'Cancel', // Text on the cancel button
        true, // Show flash icon
        ScanMode.BARCODE, // Scan mode: BARCODE or QR_CODE
      );
      if (barcodeScanRes != '-1') {
        addSerial(barcodeScanRes);
      }
    } catch (e) {
      print('Error scanning barcode: $e');
    }
  }

  // Function to save invoice and serials to the server
  Future<void> saveInvoice() async {
    String url = 'https://your-api-url.com/save_invoice'; // Replace with your API URL

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'invoice_code': widget.invoiceCode, // استخدام invoiceCode الممرر
          'customer_name': widget.customerName, // استخدام customerName الممرر
          'serials': serials,
        }),
      );

      if (response.statusCode == 200) {
        // If the server responds with OK
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('تم بنجاح'),
            content: Text('تم حفظ الفاتورة والسريالات بنجاح.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    serials.clear(); // Clear the list after saving
                  });
                },
                child: Text('حسناً'),
              ),
            ],
          ),
        );
      } else {
        // If there was an error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('خطأ'),
            content: Text('فشل في حفظ الفاتورة. حاول مرة أخرى.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('حسناً'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error saving invoice: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('خطأ'),
          content: Text('حدث خطأ أثناء الاتصال بالخادم.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('تسليم'),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'فاتورة / إضافة سيريال',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Card(
                  color: Colors.white60,
                  elevation: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20),
                        // Displaying invoice code and customer name
                        Text(
                          'رقم الفاتورة: ${widget.invoiceCode}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'العميل: ${widget.customerName}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'أدخل السيريال أو امسحه باستخدام الكاميرا:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: serialController,
                          decoration: InputDecoration(
                            labelText: 'أدخل السريال',
                            suffixIconColor: Color.fromARGB(255, 37, 41, 127),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 37, 41, 127),
                                    width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 37, 41, 127),
                                    width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: scanBarcode,
                              icon: Icon(Icons.camera_alt),
                              label: Text(
                                'مسح الباركود',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 235, 195, 63),
                                padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              ),
                            ),
                            SizedBox(width: 40),
                            ElevatedButton(
                              onPressed: () => addSerial(serialController.text),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 235, 195, 63),
                                padding:
                                EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              ),
                              child: Text(
                                'تأكيد السريال',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'عدد السيريلات: ${serials.length}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (serials.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: serials.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          serials[index],
                          textAlign: TextAlign.right,
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              serials.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    saveInvoice(); // Call saveInvoice on button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 235, 195, 63),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'تأكيد التسليم',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
