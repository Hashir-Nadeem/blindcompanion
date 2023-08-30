import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countup/countup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend.dart/getDocuments.dart';

int turn = 0;

class MySelfVolunteerHelp extends StatefulWidget {
  @override
  State<MySelfVolunteerHelp> createState() => _MySelfVolunteerHelpState();
}

class _MySelfVolunteerHelpState extends State<MySelfVolunteerHelp> {
  late List<Map<String, dynamic>> blindData = [];
  late List<Map<String, dynamic>> volunteerData = [];

  @override
  void initState() {
    super.initState();
    GetDocuments.getBlindData().then((data) {
      setState(() {
        blindData = data;
        print(blindData);
      });
    }).catchError((error) {
      // Handle error
      print(error);
    });
    GetDocuments.getVolunteerData().then((data) {
      setState(() {
        volunteerData = data;
      });
    }).catchError((error) {
      // Handle error
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return (Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg4.png'), fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  color: Colors.deepOrange,
                  child: Row(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: const Text(
                              'UK',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Countup(
                            begin: 0,
                            end: 1000000 * 1.0,
                            duration: const Duration(seconds: 3),
                            separator: ',',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     const Text(
                      //       'UK',
                      //       style: TextStyle(
                      //           fontSize: 24, fontWeight: FontWeight.bold),
                      //     ),
                      //     Countup(
                      //       begin: 0,
                      //       end: 8000,
                      //       duration: const Duration(seconds: 3),
                      //       separator: ',',
                      //       style: const TextStyle(
                      //         color: Colors.orange,
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'US',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Countup(
                            begin: 0,
                            end: 2000000 * 1.0,
                            duration: const Duration(seconds: 3),
                            separator: ',',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'Europe',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Countup(
                            begin: 0,
                            end: 30000000 * 1.0,
                            duration: const Duration(seconds: 3),
                            separator: ',',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 10,
                    child: SizedBox(
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
                              SizedBox(
                                height: screenHeight * 0.05,
                              ),
                              MyDoubleIconTextButton(
                                text: 'I am a Blind'.tr,
                                image: 'images/blind_icon.png',
                                color: Colors.deepOrange,
                                ontap: () {
                                  turn = 1;
                                  storeSelectedRole('Blind');
                                  AppNavigation.push(
                                      context, MyWelcomeScreen());
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.05,
                              ),
                              MyDoubleIconTextButton(
                                text: 'I am a Volunteer'.tr,
                                image: 'images/volunteer_icon.png',
                                color: Colors.deepOrange,
                                ontap: () {
                                  turn = 2;
                                  storeSelectedRole('Volunteer');
                                  AppNavigation.push(
                                      context, MyWelcomeScreen());
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
      ),
    ));
  }

  void storeSelectedRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedRole', role);
  }
}
