import 'package:flutter/material.dart';

class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            child: Image.asset('lib/signUpAndLoginPage/assets/img/logo.png'),
          ),
          Text(
            'SPPU',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Color.fromRGBO(0, 206, 217, 1.0),
            ),
          )
        ],
      ),
    );
  }
}
