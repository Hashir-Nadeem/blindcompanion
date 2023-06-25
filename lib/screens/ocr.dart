import 'package:flutter/material.dart';

class MyOcr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return (Scaffold(
        appBar: AppBar(),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/ocr.jpg'))),
        )));
  }
}
