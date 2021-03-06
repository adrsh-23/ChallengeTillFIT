import 'package:flutter/material.dart';
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
          Navigator.popAndPushNamed(context, "homePage");
        });
      }
    });
  }

  FocusNode _emailTextFieldFocus = FocusNode();
  FocusNode _passwordTextFieldFocus = FocusNode();
  Color _emailBgColor = Colors.transparent,
      _passwordBgColor = Colors.transparent;
  void initState() {
    _emailTextFieldFocus.addListener(() {
      if (_emailTextFieldFocus.hasFocus) {
        setState(() {
          _emailBgColor = Color.fromRGBO(255, 255, 255, 0.1);
        });
      } else {
        setState(() {
          _emailBgColor = Colors.transparent;
        });
      }
    });
    _passwordTextFieldFocus.addListener(() {
      if (_passwordTextFieldFocus.hasFocus) {
        setState(() {
          _passwordBgColor = Color.fromRGBO(255, 255, 255, 0.1);
        });
      } else {
        setState(() {
          _passwordBgColor = Colors.transparent;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Please Sign in to continue',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            cursorColor: Colors.white,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
              fillColor: _emailBgColor,
              filled: true,
              border: InputBorder.none,
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            focusNode: _emailTextFieldFocus,
            onChanged: (value) => email = value,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(fontSize: 20, color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              fillColor: _passwordBgColor,
              filled: true,
              border: InputBorder.none,
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            focusNode: _passwordTextFieldFocus,
            onChanged: (value) => password = value,
            obscureText: true,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: Container(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.tealAccent),
              ),
            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "signupPage");
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.tealAccent),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
