import 'package:ctf_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userId;
  String username;
  String profilePic = '';
  bool dataPresent = false;
  var userStream;
  initState() {
    super.initState();
    String userId = FirebaseAuth.instance.currentUser.uid;
    setState(() {
      userId = userId;
      userStream = usersCollection.where('uid', isEqualTo: userId).snapshots();
    });
    getCurrentUserInfo();
  }

  getCurrentUserInfo() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc =
        await usersCollection.doc(firebaseUser.uid).get();
    setState(() {
      username = userDoc['username'];
      profilePic = userDoc['profilePic'];
      dataPresent = true;
    });
  }

  getImage(String url) {
    try {
      return NetworkImage(url);
    } catch (e) {
      return NetworkImage(
          "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
