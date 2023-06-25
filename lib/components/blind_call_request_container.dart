import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/screens/call.dart';
import 'package:flutter/material.dart';

class MyBlindCallRequestContainer extends StatelessWidget {
  const MyBlindCallRequestContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return (Container(
      height: screenHeight * 0.2,
      width: screenWidth * 1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green)),
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Text(
                    AppTexts.scam_likely,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Wrap(children: [
                    Text(
                      AppTexts.scam_likely_requesting,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  AppNavigation.push(context, MyCall());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  AppTexts.accept,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  AppTexts.reject,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ));
  }
}
