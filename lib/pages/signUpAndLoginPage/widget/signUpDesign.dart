import 'package:flutter/material.dart';
import 'package:sppu_app/signUpAndLoginPage/widget/design.dart';

class SignUpDesignInput extends StatelessWidget {
  const SignUpDesignInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      child: ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          color: Colors.purple,
        ),
        clipper: Clipper(),
      ),
    );
  }
}
