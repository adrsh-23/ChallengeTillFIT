import 'package:ctf_app/pages/challengeUser/challengeUserPage.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as tAgo;

class ViewUserPage extends StatefulWidget {
  ViewUserPage({this.userId, this.challengedUser});
  final String challengedUser;
  final String userId;
  @override
  _ViewUserPageState createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  String username;
  String profilePic = '';
  bool dataPresent1 = false;
  bool dataPresent2 = false;
  String currUsername;
  String currProfilePic;
  var userStream;
  initState() {
    super.initState();
    setState(() {
      userStream = userPosts.where('uid', isEqualTo: widget.userId).snapshots();
    });
    getNewUserInfo();
  }

  getNewUserInfo() async {
    int count = 0;
    DocumentSnapshot userDoc = await usersCollection.doc(widget.userId).get();
    setState(() {
      username = userDoc['username'];
      profilePic = userDoc['profilePic'];
      dataPresent1 = true;
      print(username);
    });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDocument =
        await usersCollection.doc(firebaseUser.uid).get();
    setState(() {
      currUsername = userDocument['username'];
      currProfilePic = userDocument['profilePic'];
      dataPresent2 = true;
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
        title: Text(
          "User Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.tealAccent,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: dataPresent1 & dataPresent2
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        color: Colors.tealAccent,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
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
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              child: Text(
                                "Challenge this user!",
                                style: TextStyle(color: Colors.tealAccent),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (states) => Color.fromRGBO(0, 16, 48, 1),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChallengeUser(
                                    userId: widget.userId,
                                    challengedName: widget.challengedUser,
                                    profilePic: currProfilePic,
                                    username: currUsername,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.black,
                  ),
                  Container(
                    color: Colors.tealAccent,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "User Accomplishments",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
