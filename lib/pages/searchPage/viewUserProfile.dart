import 'package:ctf_app/pages/challengeUser/challengeUserPage.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewUserPage extends StatefulWidget {
  ViewUserPage({this.userId});
  final String userId;
  @override
  _ViewUserPageState createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  String username;
  String profilePic = '';
  bool dataPresent = false;
  var userStream;
  initState() {
    super.initState();
    setState(() {
      userStream = userPosts.where('uid', isEqualTo: widget.userId).snapshots();
    });
    getCurrentUserInfo();
  }

  getCurrentUserInfo() async {
    DocumentSnapshot userDoc = await usersCollection.doc(widget.userId).get();
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
      appBar: AppBar(
        title: Text("User Profile"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: dataPresent
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        color: Colors.red,
                      ),
                      Column(
                        children: [
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    child: Text(
                      "Challenge this user!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ChallengeUser(
                          userId: widget.userId,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "User Accomplishments",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        getImage(userDoc['profilePic']),
                                  ),
                                  title: Text(userDoc['username'],
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    children: [
                                      if (userDoc['type'] == 1)
                                        Text(userDoc['text'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      if (userDoc['type'] == 2)
                                        Image(
                                          image: getImage(userDoc['image']),
                                        ),
                                      if (userDoc['type'] == 3)
                                        Column(
                                          children: [
                                            Text(userDoc['text'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Image(
                                              image: getImage(userDoc['image']),
                                            )
                                          ],
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
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
