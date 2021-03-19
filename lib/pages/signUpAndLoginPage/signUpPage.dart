import 'package:flutter/material.dart';
import 'package:sppu_app/signUpAndLoginPage/widget/signUpDesign.dart';
import 'package:sppu_app/signUpAndLoginPage/widget/signUpInput.dart';
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
              SignUpDesignInput(),
              GenderBox(),
              SignUpInput(),
            ],
          ),
        ),
      ),
    );
  }
}
