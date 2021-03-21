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
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
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
                return Card(
                  color: Colors.transparent,
                  child: ListTile(
                    tileColor: Colors.tealAccent.withOpacity(0.5),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(challengeDoc['profilePic']),
                    ),
                    title: Text(
                      challengeDoc['challenge'],
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'By ${challengeDoc['challengerName']}',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[400]),
                        ),
                        Text(
                          tAgo
                              .format(challengeDoc['timeStamp'].toDate())
                              .toString(),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    trailing: MaterialButton(
                      color: Color.fromRGBO(0, 16, 48, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .runTransaction((Transaction myTransaction) async {
                          myTransaction
                              .delete(snapshots.data.docs[index].reference);
                        });
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.tealAccent,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshots.data.docs.length,
            );
          }),
    );
  }
}
