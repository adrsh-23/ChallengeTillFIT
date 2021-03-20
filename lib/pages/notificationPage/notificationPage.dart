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
                  title: Text(
                    challengeDoc['challengerName'],
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        challengeDoc['challenge'],
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            tAgo
                                .format(challengeDoc['timeStamp'].toDate())
                                .toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      MaterialButton(
                        color: Colors.white,
                        onPressed: () async {
                          await FirebaseFirestore.instance.runTransaction(
                              (Transaction myTransaction) async {
                            myTransaction
                                .delete(snapshots.data.docs[index].reference);
                          });
                        },
                        child: Text("Decline"),
                      ),
                    ],
                  ),
                );
              },
              itemCount: snapshots.data.docs.length,
            );
          }),
    );
  }
}
