import 'package:ctf_app/pages/signUpAndLoginPage/function/inputFieldDecorate.dart';
import 'package:ctf_app/pages/signUpAndLoginPage/widget/signInButton.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String gender = "M";

class SignUpInput extends StatefulWidget {
  @override
  _SignUpInputState createState() => _SignUpInputState();
}

class _SignUpInputState extends State<SignUpInput> {
  String username;
  String name;
  String email;
  String password;
  String gender;
  signUp() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((signedUser) {
      usersCollection.doc(signedUser.user.uid).set({
        'username': username,
        'name': name,
        'email': email,
        'uid': signedUser.user.uid,
        'gender': gender,
        'profilePic': 'https://i.redd.it/v0caqchbtn741.jpg',
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: inputFieldDecorate("Username"),
            autocorrect: false,
            onChanged: (value) => username = value,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: inputFieldDecorate("Email"),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: inputFieldDecorate("Password"),
            obscureText: true,
            onChanged: (value) => password = value,
          ),
          const SizedBox(
            height: 10,
          ),
          LogInButton(
            label: "Sign Up",
            onPressed: () => signUp(),
          ),
        ],
      ),
    );
  }
}
