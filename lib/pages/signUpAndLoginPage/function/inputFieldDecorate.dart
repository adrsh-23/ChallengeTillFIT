import 'package:flutter/material.dart';

inputFieldDecorate(label) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    labelText: label,
    labelStyle: TextStyle(fontSize: 20),
  );
}
