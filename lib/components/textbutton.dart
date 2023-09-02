import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
      {super.key,
      required this.text,
      required this.color,
      required this.ontap,
        this.isBorderEnabled = false
      });
  final String text;
  final Color color;
  final void Function() ontap;
  final bool isBorderEnabled;
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
        width: screenWidth * 0.99,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(8.0),
            border:  isBorderEnabled ? Border.all(
                width: 2
            ) : null
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
              fontSize: 18, color: isBorderEnabled ? Colors.black : Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    ));
  }
}
