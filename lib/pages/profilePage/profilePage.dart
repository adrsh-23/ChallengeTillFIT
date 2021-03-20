import 'package:ctf_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as tAgo;

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
      userStream = userPosts.where('uid', isEqualTo: userId).snapshots();
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
    return Scaffold(
      body: dataPresent
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        color: Colors.tealAccent,
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).padding.top,
                            color: Colors.tealAccent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.edit), onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.logout),
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushNamed(context, "loginPage");
                                  }),
                            ],
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(profilePic),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            username,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      color: Colors.tealAccent,
                      child: Text(
                        "User Accomplishments",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: userStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot userDoc =
                                  snapshot.data.docs[index];
                              return Card(
                                color: Colors.tealAccent.withOpacity(0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      tileColor: Colors.transparent,
                                      title: Text(
                                        userDoc['username'],
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            getImage(userDoc['profilePic']),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (userDoc['type'] == 1 ||
                                        userDoc['type'] == 3)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          userDoc['text'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (userDoc['type'] == 2 ||
                                        userDoc['type'] == 3)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: getImage(userDoc['image']),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            tAgo
                                                .format(userDoc['timeStamp']
                                                    .toDate())
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[300]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
