class LoginModel {
  final String code;
  final String password;
  final String name; // Add the name variable

  LoginModel({
    required this.code,
    required this.password,
    required this.name, // Include name in the constructor
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'password': password,
      'name': name, // Add name to the JSON representation
    };
  }
}

