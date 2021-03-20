import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  String currentUser;
  var userStream;
  QuerySnapshot challenges;
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser.uid;
    super.initState();
    userStream = usersCollection
        .doc()
        .collection("challenges")
        .where('uid', isEqualTo: currentUser)
        .snapshots();
    print(userStream);
    getChallenges();
  }

  getChallenges() async {
    challenges =
        await usersCollection.doc(currentUser).collection("challenges").get();
    print(challenges.docs[0]['challenger']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: challenges.docs.length,
          itemBuilder: (BuildContext context, index) {
            if (challenges.docs[index] == null) {
              return CircularProgressIndicator();
            }
            return Card(
              child: ListTile(),
            );
          }),
    );
  }
}
