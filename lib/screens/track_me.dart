import 'package:flutter/material.dart';

class MyTrackMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return (Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/where_am_i.jpg'),
                  fit: BoxFit.fill)),
        )));
  }
}
