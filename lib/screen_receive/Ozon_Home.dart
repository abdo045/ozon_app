import 'package:flutter/material.dart';
import 'package:ozon/screen_receive/appdrawer.dart';
import 'delivery_invoices.dart';
import 'store_keeper.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class OzonHome extends StatelessWidget {
  const OzonHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.userId;
    final employeeName = authProvider.employeeName; // Fetching the employee's name
    final role = userId == 1 ? 'استلام' : 'تسليم'; // Determining role based on userId

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ozon Home'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'الاسم: $employeeName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'الوظيفة: $role',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20), // Adding space between the name/role and buttons
            if (userId == 1) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 25),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryInvoices()));
                },
                child: const Text('عرض فواتير الاستلام'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreKeeper()));
                },
                child: const Text('عرض الفواتير المكتملة'),
              ),
            ] else if (userId == 2) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryInvoices()));
                },
                child: const Text('عرض فواتير التسليم'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreKeeper()));
                },
                child: const Text('عرض الفواتير المكتملة'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
