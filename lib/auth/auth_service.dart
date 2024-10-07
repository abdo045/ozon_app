import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ozon/model/login_model.dart';


class AuthService {
  Future<LoginResponse?> login(String code, String password) async {
    try {
      String apiUrl = 'https://your-api-url.com/api/login'; // ضع هنا رابط الـ API
      LoginModel loginModel = LoginModel(code: code, password: password, name: '');

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginModel.toJson()),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}

class LoginResponse {
  final int id;

  LoginResponse({required this.id});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
    );
  }
}
