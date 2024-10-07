import 'package:flutter/material.dart';
import 'package:ozon/screen_receive/Ozon_Home.dart';
import 'package:ozon/screen_receive/appdrawer.dart';
import 'package:ozon/screen_receive/delivery_invoices.dart';
import 'package:ozon/screen_receive/edit_invoices.dart';
import 'package:ozon/screen_receive/login.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ozon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  EditInvoices(invoiceCode: '', customerName: '',),
    );
  }
}
