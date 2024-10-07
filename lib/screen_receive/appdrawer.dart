import 'package:flutter/material.dart';
import 'package:ozon/screen_receive/login.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context).userId;
    final profileImage = Provider.of<AuthProvider>(context).profileImage;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(Provider.of<AuthProvider>(context).employeeName ?? 'اسم المستخدم'),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: profileImage != null ? FileImage(profileImage) : null,
              child: profileImage == null
                  ? Icon(Icons.person, size: 50, color: Colors.grey)
                  : null,
            ),
            otherAccountsPictures: [
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () => _selectImage(context),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('الرئيسية'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.receipt_long),
            title: Text('أوامر المندوب'),
            children: <Widget>[
              if (userId == 1) ...[
                ListTile(
                  leading: Icon(Icons.delivery_dining),
                  title: Text('تسليم فواتير'),
                  onTap: () {
                    // التنقل إلى صفحة تسليم الفواتير
                  },
                ),
                ListTile(
                  leading: Icon(Icons.receipt),
                  title: Text('استلام فواتير'),
                  onTap: () {
                    // التنقل إلى صفحة استلام الفواتير
                  },
                ),
              ] else if (userId == 2) ...[
                ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text('قائمة الفواتير المكتملة'),
                  onTap: () {
                    // التنقل إلى صفحة الفواتير المكتملة
                  },
                ),
              ],
            ],
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('تسجيل الخروج'),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _selectImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Provider.of<AuthProvider>(context, listen: false)
          .setProfileImage(File(pickedFile.path));
    }
  }
}

