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
              backgroundColor: Colors.tealAccent,
              leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onTap: () => Navigator.pop(context),
              ),
              title: Text(
                "Show your Achievement",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  imagePath == null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton(
                            child: Text(
                              'Upload Image',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () => optionsDialog(),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => Colors.tealAccent,
                              ),
                            ),
                          ),
                        )
                      : MediaQuery.of(context).viewInsets.bottom > 0
                          ? Container()
                          : Image(
                              width: 300,
                              height: 300,
                              image: FileImage(imagePath),
                            ),
                  TextField(
                    onChanged: (value) => text = value,
                    maxLength: null,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.tealAccent.withOpacity(0.5),
                      filled: true,
                      labelText: "Write Caption",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.tealAccent,
              child: Icon(
                Icons.publish,
                color: Colors.black,
              ),
              onPressed: () => postText(),
            ),
          );
  }
}
