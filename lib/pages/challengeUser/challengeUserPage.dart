import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChallengeUser extends StatefulWidget {
  final String userId;
  final String challengedName;
  final String username;
  final String profilePic;
  ChallengeUser(
      {this.userId, this.challengedName, this.username, this.profilePic});
  @override
  _ChallengeUserState createState() => _ChallengeUserState();
}

class _ChallengeUserState extends State<ChallengeUser> {
  String text;
  String username;
  String profilePic;

  postChallenge() async {
    var firebaseUser = FirebaseAuth.instance.currentUser.uid;
    await usersCollection
        .doc(widget.userId)
        .collection("challenges")
        .doc()
        .set({
      'challenged': widget.userId,
      'challenger': firebaseUser,
      'challengedName': widget.challengedName,
      'challengerName': widget.username,
      'profilePic': widget.profilePic,
      'timeStamp': DateTime.now(),
      'challenge': text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Challenge Now!",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,
        child: TextField(
            onChanged: (value) => text = value,
            maxLength: null,
            maxLines: null,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
                labelText: "Write Your Challenge",
                fillColor: Colors.tealAccent.withOpacity(0.7),
                filled: true,
                labelStyle: TextStyle(
                  fontSize: 29,
                  color: Colors.black,
                ),
                border: InputBorder.none)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        child: Icon(Icons.publish, color: Colors.black),
        onPressed: () => postChallenge(),
      ),
    );
  }
}
