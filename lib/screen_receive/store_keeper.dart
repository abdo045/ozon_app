import 'package:flutter/material.dart';

class StoreKeeper extends StatelessWidget {
  const StoreKeeper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Keeper'),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'مرحبًا بك في إدارة المبيعات',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // قائمة بالفواتير أو الطلبات
            Expanded(
              child: ListView.builder(
                itemCount: 10, // عدد العناصر (يمكن تغييره حسب الحاجة)
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('فاتورة رقم ${index + 1}'),
                      subtitle: Text('تاريخ: 2024-09-12'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // وظيفة تعديل الفاتورة
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // وظيفة إضافة فاتورة جديدة
              },
              child: const Text('إضافة فاتورة جديدة'),
            ),
          ],
        ),
      ),
    );
  }
}
