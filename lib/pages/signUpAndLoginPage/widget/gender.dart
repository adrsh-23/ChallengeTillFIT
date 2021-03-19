import 'package:flutter/material.dart';

class ReuseContainer extends StatelessWidget {
  ReuseContainer({@required this.colour, this.getChild});
  final Color colour;
  final getChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: getChild,
      decoration: BoxDecoration(
          color: colour,
          // border: Border.all(color: colour),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}

class ReuseIcons extends StatelessWidget {
  ReuseIcons({this.label, this.getIcon});
  final String label;
  final Widget getIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getIcon,
        const SizedBox(
          height: 10,
        ),
        Text(label, style: TextStyle(fontSize: 20)),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
