import 'package:flutter/material.dart';
import 'dart:io';

class AuthProvider with ChangeNotifier {
  int _userId = 0;
  String? _employeeName;
  File? _profileImage;

  int get userId => _userId;
  String? get employeeName => _employeeName;
  File? get profileImage => _profileImage;

  void setUserId(int id) {
    _userId = id;
    notifyListeners();
  }

  void setEmployeeName(String name) {
    _employeeName = name;
    notifyListeners();
  }

  void setProfileImage(File image) {
    _profileImage = image;
    notifyListeners();
  }

  void logout() {
    // تنفيذ تسجيل الخروج
    _userId = 0;
    _employeeName = null;
    _profileImage = null;
    notifyListeners();
  }
}
