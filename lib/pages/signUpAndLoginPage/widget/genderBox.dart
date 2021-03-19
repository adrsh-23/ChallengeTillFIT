import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sppu_app/signUpAndLoginPage/widget/gender.dart';

const inactiveColor = Colors.white;
const activeColor = Color.fromRGBO(211, 32, 132, 1.0);
enum genderType { male, female }
enum operationType { plus, minus }
enum valueReq { weight, age }
genderType currentGender;

class GenderBox extends StatefulWidget {
  @override
  _GenderBoxState createState() => _GenderBoxState();
}

class _GenderBoxState extends State<GenderBox> {
  String gender;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    2.0, // Move to right 10  horizontally
                    2.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: GestureDetector(
              onTap: () => setState(() {
                currentGender = genderType.male;
                gender = "M";
              }),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: ReuseContainer(
                    colour: currentGender == genderType.male
                        ? activeColor
                        : inactiveColor,
                    getChild: ReuseIcons(
                      label: "MALE",
                      getIcon: Icon(
                        FontAwesomeIcons.mars,
                        size: 79,
                      ),
                    )),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              )
            ]),
            child: GestureDetector(
              onTap: () => setState(() {
                currentGender = genderType.female;
                gender = "F";
              }),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: ReuseContainer(
                  colour: currentGender == genderType.female
                      ? activeColor
                      : inactiveColor,
                  getChild: ReuseIcons(
                    label: "FEMALE",
                    getIcon: Icon(FontAwesomeIcons.venus, size: 79),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
