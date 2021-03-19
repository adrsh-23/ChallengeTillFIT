import 'package:ctf_app/pages/signUpAndLoginPage/function/inputFieldDecorate.dart';
import 'package:ctf_app/pages/signUpAndLoginPage/utils/variables.dart';
import 'package:ctf_app/pages/signUpAndLoginPage/widget/gender.dart';
import 'package:ctf_app/pages/signUpAndLoginPage/widget/signInButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String gender = "M";
const inactiveColor = Colors.white;
const activeColor = Color.fromRGBO(211, 32, 132, 1.0);
enum genderType { male, female }
enum operationType { plus, minus }
enum valueReq { weight, age }
genderType currentGender;

class SignUpInput extends StatefulWidget {
  @override
  _SignUpInputState createState() => _SignUpInputState();
}

class _SignUpInputState extends State<SignUpInput> {
  String username;
  String name;
  String email;
  String password;
  String phoneNo;
  String collegeName;
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
        'collegeName': collegeName,
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
          TextField(
            decoration: inputFieldDecorate("Phone no"),
            keyboardType: TextInputType.number,
            onChanged: (value) => phoneNo = value,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: inputFieldDecorate("College Name"),
            onChanged: (value) => collegeName = value,
          ),
          const SizedBox(
            height: 20,
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

class GenderBox extends StatefulWidget {
  @override
  _GenderBoxState createState() => _GenderBoxState();
}

class _GenderBoxState extends State<GenderBox> {
  @override
  Widget build(BuildContext context) {
    var FontAwesomeIcons;
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    2.0, // Move to right 10  horizontally
                    2.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: GestureDetector(
              onTap: () => setState(() {
                currentGender = genderType.male;
                gender = "M";
                print(gender);
              }),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: ReuseContainer(
                    colour: currentGender == genderType.male
                        ? activeColor
                        : inactiveColor,
                    getChild: ReuseIcons(
                      label: "MALE",
                      getIcon: Icon(
                        FontAwesomeIcons.mars,
                        size: 79,
                      ),
                    )),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              )
            ]),
            child: GestureDetector(
              onTap: () => setState(() {
                currentGender = genderType.female;
                gender = "F";
                print(gender);
              }),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: ReuseContainer(
                  colour: currentGender == genderType.female
                      ? activeColor
                      : inactiveColor,
                  getChild: ReuseIcons(
                    label: "FEMALE",
                    getIcon: Icon(FontAwesomeIcons.venus, size: 79),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
