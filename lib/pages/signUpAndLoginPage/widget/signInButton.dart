import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  LogInButton({this.label, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color.fromRGBO(211, 32, 132, 1.0),
      ),
    );
  }
}
