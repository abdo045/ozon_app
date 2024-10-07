import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  int _userId = 0;
  int get userId => _userId;
  String _employeeName = '';
  String get employeeName => _employeeName;

  void setUserId(int id, String name) {
    _userId = id;
    _employeeName = name; // تحديث الاسم
    notifyListeners();
  }

  void logout() {
    _userId = 0; // إعادة تعيين معرف المستخدم
    _employeeName = ''; // إعادة تعيين الاسم
    notifyListeners();
  }
}
