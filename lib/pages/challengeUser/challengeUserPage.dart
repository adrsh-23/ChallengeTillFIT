import 'package:ctf_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChallengeUser extends StatefulWidget {
  final String userId;
  ChallengeUser({this.userId});
  @override
  _ChallengeUserState createState() => _ChallengeUserState();
}

class _ChallengeUserState extends State<ChallengeUser> {
  String text;
  postChallenge() {
    var firebaseUser = FirebaseAuth.instance.currentUser.uid;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Challenge Now!"),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Expanded(
          child: TextField(
              onChanged: (value) => text = value,
              maxLength: null,
              maxLines: null,
              style: TextStyle(
                fontSize: 24,
              ),
              decoration: InputDecoration(
                  labelText: "Write Something",
                  labelStyle: TextStyle(
                    fontSize: 29,
                  ),
                  border: InputBorder.none)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.publish),
        onPressed: () => postChallenge(),
      ),
    );
  }
}
