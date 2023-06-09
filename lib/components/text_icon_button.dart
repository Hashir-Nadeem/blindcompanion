import 'package:flutter/material.dart';

class MyTextIconButton extends StatelessWidget {
  const MyTextIconButton({super.key, required this.text, required this.ontap});
  final void Function() ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double fontSize = constraints.maxWidth *
            0.06; // Adjust the multiplication factor as per your preference
        TextStyle textStyle = TextStyle(
            fontSize: fontSize,
            color: Colors.white,
            fontWeight: FontWeight.bold);

        return FractionallySizedBox(
            widthFactor: 0.9, // Adjust the width factor as per your preference
            child: InkWell(
                onTap: ontap,
                child: Container(
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        this.text,
                        style: textStyle,
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      )
                    ],
                  ),
                )));
      },
    );
  }
}
