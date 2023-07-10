import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:blind_companion/screens/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countup/countup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend.dart/getDocuments.dart';
import 'blind_main_screen.dart';

int turn = 0;

class MySelfVolunteerHelp extends StatefulWidget {
  @override
  State<MySelfVolunteerHelp> createState() => _MySelfVolunteerHelpState();
}

class _MySelfVolunteerHelpState extends State<MySelfVolunteerHelp> {
  late List<Map<String, dynamic>> blindData = [];
  late List<Map<String, dynamic>> volunteerData = [];
  late FirebaseAuth _auth;
  late FirebaseFirestore firestore;
  var isLoading = false;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 2000), () {
      _auth = FirebaseAuth.instance;
      firestore = FirebaseFirestore.instance;
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
          print(volunteerData);
        });
      }).catchError((error) {
        // Handle error
        print(error);
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return (Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'images/bg_eyes.png',
              fit: BoxFit.cover,
              // height: 250,
            ),
            SingleChildScrollView(
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
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: const Text(
                                'Blinds',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Countup(
                              begin: 0,
                              end: blindData.length * 1.0,
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
                        const Spacer(),
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
                                'Volunteers',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Countup(
                              begin: 0,
                              end: volunteerData.length * 1.0,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.05,
                                ),
                                MyDoubleIconTextButton(
                                  text: 'I am a Blind'.tr,
                                  image: 'images/blind_icon.png',
                                  color: Colors.deepOrange,
                                  ontap: () async {
                                    turn = 1;
                                    storeSelectedRole('Blind');
                                    if (_auth.currentUser != null) {
                                      GetDocuments.getDocumentsData();
                                      await storeSelectedlang();
                                      AppNavigation.push(
                                          context, MyBlindScreen());
                                    } else {
                                      AppNavigation.push(
                                          context, MyWelcomeScreen());
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: screenHeight * 0.05,
                                ),
                                MyDoubleIconTextButton(
                                  text: 'I am a Volunteer'.tr,
                                  image: 'images/volunteer_icon.png',
                                  color: Colors.deepOrange,
                                  ontap: () async {
                                    turn = 2;
                                    storeSelectedRole('Volunteer');
                                    if (_auth.currentUser != null) {
                                      GetDocuments.getDocumentsData();
                                      await storeSelectedlang();
                                      AppNavigation.push(
                                          context, MyVolunteerScreen());
                                    } else {
                                      AppNavigation.push(
                                          context, MyWelcomeScreen());
                                    }
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
            isLoading
                ? Container(
                    color: Colors.black.withOpacity(.5),
                    child: Center(
                        child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                        strokeWidth: 3,
                      ),
                    )),
                  )
                : Container(),
          ],
        ),
      ),
    ));
  }

  void storeSelectedRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedRole', role);
  }

  Future<void> storeSelectedlang() async {
    GetDocuments.getVolunteerData().then((data) {
      setState(() {
        volunteerData = data;
      });
      DocumentReference docRef =
          firestore.collection('volunteer_users').doc(_auth.currentUser!.uid);
      print('hello' + '${_auth.currentUser!.uid}');

      docRef.get().then((DocumentSnapshot snapshot) async {
        if (snapshot.exists) {
          // Document exists, you can access its data using snapshot.data()
          var data = (snapshot.data() as Map<String, dynamic>)['language'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('selectedlang', data);

          // Process the data as needed
          //fetch language and then compare it with locale
          if (data == 'ur PK') {
            var locale = const Locale('ur', 'PK');
            Get.updateLocale(locale);
          } else if (data == 'en US') {
            var locale = const Locale('en', 'US');
            Get.updateLocale(locale);
          }
        } else {
          // Document does not exist
          print('Document does not exist');
        }
      }).catchError((error) {
        print('Error getting document: $error');
      });
    }).catchError((error) {
      // Handle error
      print(error);
    });
  }
}
