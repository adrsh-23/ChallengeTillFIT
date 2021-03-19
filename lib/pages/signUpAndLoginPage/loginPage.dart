import 'package:flutter/material.dart';
import 'package:sppu_app/documentPage/documentListPage.dart';
import './widget/logo.dart';
import './widget/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  bool isSignedIn = false;

  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          isSignedIn = true;
        });
      } else {
        setState(() {
          isSignedIn = false;
        });
      }
    });
  }

  double boxHeight;
  double bottomHeight() {
    setState(() {
      boxHeight = MediaQuery.of(context).viewInsets.bottom;
    });
    print(boxHeight);
    return boxHeight;
  }

  @override
  Widget build(BuildContext context) {
    return isSignedIn == false
        ? Scaffold(
            body: Center(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    logo(),
                    SizedBox(
                      height: 10,
                    ),
                    LogIn(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text("Don't have an account? "),
                    //     GestureDetector(
                    //       onTap: () => Navigator.pushNamed(context, "signUp"),
                    //       child: Text(
                    //         "Sign Up",
                    //         style: TextStyle(color: Colors.blue),
                    //       ),
                    //     )
                    //   ],

                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          )
        : DocumentListPage();
  }
}
