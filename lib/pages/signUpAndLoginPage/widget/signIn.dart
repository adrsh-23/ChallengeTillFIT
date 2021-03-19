import 'package:ctf_app/pages/signUpAndLoginPage/function/inputFieldDecorate.dart';
import 'package:flutter/material.dart';
import './forgotButton.dart';
import './signInButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email;
  bool invalid = false;
  String password;
  String error = "";
  loginUser() async {
    print(error);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      error = e.toString();
    }
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (error.isNotEmpty) {
        setState(() {
          invalid = true;
        });
      } else {
        setState(() {
          // invalid = false;
          Navigator.pushNamed(context, "homePage");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: inputFieldDecorate('Email'),
            onChanged: (value) => email = value,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: inputFieldDecorate('Password'),
            onChanged: (value) => password = value,
            obscureText: true,
          ),
          ForgotButton(),
          SizedBox(
            height: 10,
          ),
          LogInButton(
            label: "Login",
            onPressed: () => loginUser(),
          ),
          SizedBox(
            height: 5,
          ),
          if (error.isNotEmpty)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (error.split(" ").contains("password"))
                Text(
                  "Invalid Password",
                  style: TextStyle(color: Colors.red),
                ),
              if (error.split(" ").contains("record"))
                Text(
                  "User Does Not Exist",
                  style: TextStyle(color: Colors.red),
                ),
            ]),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "signUp"),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
