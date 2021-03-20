import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        title: Text("YOLO"),
        centerTitle: true,
        leading: Icon(Icons.food_bank),
      ),
      body: StreamBuilder(
        stream: userPosts.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot userData = snapshot.data.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      userData['username'],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: getImage(userData['profilePic']),
                    ),
                    subtitle: Column(
                      children: [
                        if (userData['type'] == 1)
                          Text(userData['text'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        if (userData['text'] == 2)
                          Image(
                            image: getImage(userData['image']),
                          ),
                        if (userData['type'] == 3)
                          Column(
                            children: [
                              Text(userData['text'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Image(
                                image: getImage(userData['image']),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
