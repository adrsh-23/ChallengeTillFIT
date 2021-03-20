import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'CTF',
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              LogIn(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
