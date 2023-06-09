import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
      {super.key,
      required this.text,
      required this.color,
      required this.ontap});
  final String text;
  final Color color;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // TODO: implement build
    return (InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: screenHeight * 0.08,
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(8.0)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
