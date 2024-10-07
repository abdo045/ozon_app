import 'package:flutter/material.dart';
import 'package:ozon/auth/auth_service.dart';
import 'package:ozon/screen_receive/Ozon_Home.dart';
import 'package:ozon/screen_receive/appdrawer.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String code;
  late String password;
  bool _isSecurePassword = true;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            Image.asset('images/favicon2.png'),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Center(
                      child: Container(
                        width: 120,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(20),
                              right: Radius.circular(20)
                          ),

                        ),
                        child: Text(
                          'المندوب',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 37, 41, 127),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.start,
                        onChanged: (value) {
                          code = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your code',
                          labelText: 'code',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        obscureText: _isSecurePassword,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: togglePassword(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Text color
                          padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                        ),
                        onPressed: () async {
                          final loginResponse = await _authService.login(code, password);
                          if (loginResponse != null) {
                            Provider.of<AuthProvider>(context, listen: false).setUserId(loginResponse.id);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OzonHome()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login failed! Please check your The company.')),
                            );
                          }
                        },
                        child: const Text('Sign In',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w700),),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? Icon(Icons.visibility_outlined)
          : Icon(Icons.visibility_off_outlined),
    );
  }
}
