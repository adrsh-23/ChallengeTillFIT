import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  String currentUser;
  var userStream;
  var challenges;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: usersCollection
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('challenges')
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
              itemBuilder: (context, index) {
                DocumentSnapshot challengeDoc = snapshots.data.docs[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(challengeDoc['profilePic']),
                  ),
                  title: Row(
                    children: [
                      Text(
                        challengeDoc['challengedName'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(challengeDoc['challenge'],
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                  subtitle: Text(
                    tAgo.format(challengeDoc['timeStamp'].toDate()).toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              itemCount: snapshots.data.docs.length,
            );
          }),
    );
  }
}
