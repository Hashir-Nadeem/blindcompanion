import 'package:flutter/material.dart';

class MyDoubleIconTextButton extends StatelessWidget {
  const MyDoubleIconTextButton(
      {super.key,
      required this.text,
      required this.image,
      required this.color,
      required this.ontap,
      this.textcolor = Colors.white});
  final String image;
  final String text;
  final Color color;
  final Color textcolor;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double fontSize = constraints.maxWidth *
            0.04; // Adjust the multiplication factor as per your preference
        TextStyle textStyle = TextStyle(
            fontSize: fontSize, color: textcolor, fontWeight: FontWeight.bold);

        return FractionallySizedBox(
            widthFactor: 0.9, // Adjust the width factor as per your preference
            child: InkWell(
                onTap: ontap,
                child: Container(
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          this.image,
                          fit: BoxFit.cover,
                          height: screenHeight * 0.06,
                        ),
                      ),
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
