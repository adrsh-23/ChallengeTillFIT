import 'dart:io';
import 'package:ctf_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool uploading = false;
  File imagePath;
  String text;

  get usercollection => null;
  pickImage(ImageSource imgSource) async {
    final Image = await ImagePicker().getImage(source: imgSource);
    setState(() {
      imagePath = File(Image.path);
    });
    Navigator.pop(context);
  }

  optionsDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text("Select Image from Gallery"),
              ),
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text("Click an Image"),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  uploadImage(String id) async {
    UploadTask storageUploadTask = userPostImage.putFile(imagePath);
    TaskSnapshot storageTaskSnapshot =
        await storageUploadTask.whenComplete(() => null);
    String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  postText() async {
    setState(() {
      uploading = true;
    });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc =
        await usersCollection.doc(firebaseUser.uid).get();
    var allDoc = await userPosts.get();
    int length = allDoc.docs.length;
    if (text != '' && imagePath == null) {
      userPosts.doc('text $length').set({
        'username': userDoc['username'],
        'profilePic': userDoc['profilePic'],
        'uid': firebaseUser.uid,
        'id': 'text $length',
        'text': text,
        'type': 1,
        'timeStamp': DateTime.now(),
      });
      Navigator.pop(context);
    } else if (text == '' && imagePath != null) {
      String imageUrl = await uploadImage('text $length');
      userPosts.doc('text $length').set({
        'username': userDoc['username'],
        'profilePic': userDoc['profilePic'],
        'uid': firebaseUser.uid,
        'id': 'text $length',
        'image': imageUrl,
        'text': '',
        'type': 2,
        'timeStamp': DateTime.now(),
      });
      Navigator.pop(context);
    } else {
      String imageUrl = await uploadImage('text $length');
      userPosts.doc('text $length').set({
        'username': userDoc['username'],
        'profilePic': userDoc['profilePic'],
        'uid': firebaseUser.uid,
        'id': 'text $length',
        'text': text,
        'image': imageUrl,
        'type': 3,
        'timeStamp': DateTime.now(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return uploading
        ? Scaffold(
            body: Center(
              child: Text("Uploading"),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                child: Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.pop(context),
              ),
              title: Text("Show your Achievement"),
              centerTitle: true,
              actions: [
                GestureDetector(
                  child: Icon(Icons.image),
                  onTap: () => optionsDialog(),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: TextField(
                      onChanged: (value) => text = value,
                      maxLength: null,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      decoration: InputDecoration(
                          labelText: "Write Something",
                          labelStyle: TextStyle(
                            fontSize: 30,
                          ),
                          border: InputBorder.none)),
                ),
                imagePath == null
                    ? Container()
                    : MediaQuery.of(context).viewInsets.bottom > 0
                        ? Container()
                        : Image(
                            width: 300,
                            height: 300,
                            image: FileImage(imagePath),
                          ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.publish),
              onPressed: () => postText(),
            ),
          );
  }
}
