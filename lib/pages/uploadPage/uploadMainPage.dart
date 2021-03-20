import 'package:ctf_app/pages/uploadPage/upload.dart';
import 'package:flutter/material.dart';

class UploadandChallenge extends StatefulWidget {
  @override
  _UploadandChallengeState createState() => _UploadandChallengeState();
}

class _UploadandChallengeState extends State<UploadandChallenge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
              onPressed: () => Navigator.pushNamed(context, "upload"),
              child: Text("Upload Your Achievement"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: MaterialButton(
              onPressed: () => null,
              child: Text("Challenge Someone"),
            ),
          ),
        ],
      ),
    );
  }
}
