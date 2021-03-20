import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ctf_app/utils/variables.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String username;
  String name;
  String email;
  String password;

  signUp() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((signedUser) {
      usersCollection.doc(signedUser.user.uid).set({
        'username': username,
        'name': name,
        'email': email,
      });
    });
    Navigator.popAndPushNamed(context, 'homePage');
  }

  FocusNode _emailTextFieldFocus = FocusNode();
  FocusNode _passwordTextFieldFocus = FocusNode();
  FocusNode _usernameTextFieldFocus = FocusNode();
  FocusNode _nameTextFieldFocus = FocusNode();
  Color _emailBgColor = Colors.transparent,
      _passwordBgColor = Colors.transparent,
      _usernameBgColor = Colors.transparent,
      _nameBgColor = Colors.transparent;
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
    _usernameTextFieldFocus.addListener(() {
      if (_usernameTextFieldFocus.hasFocus) {
        setState(() {
          _usernameBgColor = Color.fromRGBO(255, 255, 255, 0.1);
        });
      } else {
        setState(() {
          _usernameBgColor = Colors.transparent;
        });
      }
    });
    _nameTextFieldFocus.addListener(() {
      if (_nameTextFieldFocus.hasFocus) {
        setState(() {
          _nameBgColor = Color.fromRGBO(255, 255, 255, 0.1);
        });
      } else {
        setState(() {
          _nameBgColor = Colors.transparent;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: _usernameBgColor,
                    filled: true,
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    border: InputBorder.none,
                  ),
                  focusNode: _usernameTextFieldFocus,
                  autocorrect: false,
                  onChanged: (value) => username = value,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: _nameBgColor,
                    filled: true,
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    border: InputBorder.none,
                  ),
                  focusNode: _nameTextFieldFocus,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onChanged: (value) => name = value,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    fillColor: _emailBgColor,
                    filled: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    border: InputBorder.none,
                  ),
                  focusNode: _emailTextFieldFocus,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  cursorColor: Colors.white,
                  onChanged: (value) => email = value,
                  autocorrect: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  // decoration: inputFieldDecorate("Password"),
                  decoration: InputDecoration(
                    fillColor: _passwordBgColor,
                    filled: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    border: InputBorder.none,
                  ),
                  focusNode: _passwordTextFieldFocus,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: true,
                  onChanged: (value) => password = value,
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      signUp();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.tealAccent,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
