import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection("users");

CollectionReference userPosts =
    FirebaseFirestore.instance.collection("userPosts");

Reference userPostImage = FirebaseStorage.instance.ref().child('userPosts');
