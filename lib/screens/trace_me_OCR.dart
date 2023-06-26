import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/track_me.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ocr.dart';

class MyTraceMeOcr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return (Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Image.asset('images/logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                      height: screenHeight * 0.6,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Discover the Community. See the World Together'
                                  .tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            MyDoubleIconTextButton(
                              text: 'Track Me'.tr,
                              image: 'images/detective_icon.png',
                              color: Colors.deepOrange,
                              ontap: () {
                                AppNavigation.push(context, const MyTrackMe());
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MyDoubleIconTextButton(
                              text: 'OCR'.tr,
                              image: 'images/ocr.png',
                              color: Colors.deepOrange,
                              ontap: () {
                                AppNavigation.push(context, const MyOcr());
                              },
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
