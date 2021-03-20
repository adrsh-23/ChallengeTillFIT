import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userId;
  void initState() {
    userId = FirebaseAuth.instance.currentUser.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getImage(String url) {
      try {
        return NetworkImage(url);
      } catch (e) {
        return NetworkImage(
            "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      body: StreamBuilder(
        stream: userPosts.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot userData = snapshot.data.docs[index];

                return Card(
                  color: Colors.tealAccent.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        tileColor: Colors.transparent,
                        title: Text(
                          userData['username'],
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: getImage(userData['profilePic']),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (userData['type'] == 1 || userData['type'] == 3)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            userData['text'],
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      if (userData['type'] == 2 || userData['type'] == 3)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: getImage(userData['image']),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              tAgo
                                  .format(userData['timeStamp'].toDate())
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "upload"),
      ),
    );
  }
}
