import 'package:ctf_app/pages/signUpAndLoginPage/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:ctf_app/pages/signUpAndLoginPage/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "loginPage": (context) => Login(),
        "signupPage": (context) => SignUp(),
      },
    );
  }
}
