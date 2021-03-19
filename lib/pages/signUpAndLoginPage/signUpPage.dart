import 'package:ctf_app/pages/signUpAndLoginPage/widget/signUpInput.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

main() => runApp(MaterialApp(
      home: SignUp(),
      debugShowCheckedModeBanner: false,
    ));

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SignUpInput(),
            ],
          ),
        ),
      ),
    );
  }
}
