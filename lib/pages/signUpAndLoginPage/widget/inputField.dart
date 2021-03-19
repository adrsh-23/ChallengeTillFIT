import 'package:flutter/material.dart';
import '../function/inputFieldDecorate.dart';

final List inputfield = <Widget>[
  TextField(
    decoration: inputFieldDecorate('Username'),
  ),
  SizedBox(
    height: 20,
  ),
  TextField(
    decoration: inputFieldDecorate('Password'),
    obscureText: true,
  ),
];
