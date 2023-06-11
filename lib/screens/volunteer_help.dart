import 'dart:async';

import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'call.dart';

class MyVolunteerHelp extends StatelessWidget {
  const MyVolunteerHelp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(
        title: Text(
          'Self/Volunteer Help'.tr,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Discover the Community. See the World Together'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          MyDoubleIconTextButton(
                            text: 'Brief Help'.tr,
                            image: 'images/brief_icon.png',
                            color: const Color.fromRGBO(255, 87, 34, 1),
                            ontap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Icon(
                                      Icons.call,
                                      color: Colors.deepOrange,
                                      size: 30,
                                    ),
                                    content: Wrap(children: [
                                      Text(
                                          'Your request for brief help call is submitted succesfully, You will be notified shortly'
                                              .tr)
                                    ]),
                                  );
                                },
                              );

                              // Delay the navigation to the next screen
                              Timer(const Duration(seconds: 3), () {
                                AppNavigation.push(context, MyCall());
                              });
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MyDoubleIconTextButton(
                            text: 'Extended Help'.tr,
                            image: 'images/extended_help.png',
                            color: Colors.deepOrange,
                            ontap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Icon(
                                      Icons.call,
                                      color: Colors.deepOrange,
                                      size: 30,
                                    ),
                                    content: Wrap(children: [
                                      Text(
                                          'Your request for extended help call is submitted succesfully, You will be notified shortly'
                                              .tr)
                                    ]),
                                  );
                                },
                              );

                              // Delay the navigation to the next screen
                              Timer(const Duration(seconds: 3), () {
                                AppNavigation.push(context, MyCall());
                              });
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
    ));
  }
}
