import 'package:ctf_app/pages/searchPage/viewUserProfile.dart';
import 'package:ctf_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String userInput;
  Future<QuerySnapshot> searchUserResult;
  searchUsers(String s) {
    var users =
        usersCollection.where('username', isGreaterThanOrEqualTo: s).get();
    setState(() {
      searchUserResult = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onChanged: (value) => userInput = value,
          decoration:
              InputDecoration(hintText: "Search For Users", filled: true),
          onFieldSubmitted: searchUsers,
        ),
      ),
      body: searchUserResult == null
          ? Center(
              child: Text("Search For Users.."),
            )
          : FutureBuilder(
              future: searchUserResult,
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot user = snapshot.data.docs[index];
                      return Card(
                        elevation: 10.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user['profilePic']),
                          ),
                          title: Text(user['username']),
                          trailing: Container(
                              child: MaterialButton(
                            onPressed: () {
                              if (FirebaseAuth.instance.currentUser.uid ==
                                  user['uid']) {
                                Navigator.pushNamed(context, "profilePage");
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewUserPage(
                                              userId: user['uid'],
                                            )));
                              }
                            },
                            child: Text("View"),
                          )),
                        ),
                      );
                    });
              }),
    );
  }
}
