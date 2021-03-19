import 'package:ctf_app/pages/homePage/homePage.dart';
import 'package:ctf_app/pages/signUpAndLoginPage/signUpPage.dart';
import 'package:ctf_app/pages/uploadPage/upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ctf_app/pages/signUpAndLoginPage/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "loginPage": (context) => Login(),
        "signupPage": (context) => SignUp(),
        "homePage": (context) => HomePage(),
        "upload": (context) => UploadPage(),
      },
      initialRoute: 'loginPage',
    );
  }
}
