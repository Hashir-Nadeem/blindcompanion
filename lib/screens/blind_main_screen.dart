import 'dart:async';
import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/backend.dart/getDocuments.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/components/languageDropdown.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/trace_me_OCR.dart';
import 'package:blind_companion/screens/track_me.dart';
import 'package:blind_companion/screens/videocalling.dart';
import 'package:blind_companion/screens/volunteer_help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Assets/texts.dart';
import 'ocr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int checkcall = 0;
bool isBriefCall = false;

class MyBlindScreen extends StatefulWidget {
  @override
  _MyBlindScreenState createState() => _MyBlindScreenState();
}

class _MyBlindScreenState extends State<MyBlindScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  List documentsData = [];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                _user!.displayName.toString().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              titleTextStyle: const TextStyle(color: Colors.deepOrange),
              subtitle: Text(
                _user!.email.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              tileColor: const Color.fromARGB(31, 154, 153, 153),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Discover the Community. See the World Together'.tr,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      height: screenHeight * 0.6,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyDoubleIconTextButton(
                              text: 'Self Help',
                              image: 'images/self_help_icon.png',
                              color: Colors.deepOrange,
                              ontap: () {
                                AppNavigation.push(context, MyTraceMeOcr());
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            MyDoubleIconTextButton(
                              text: 'Volunteer Help',
                              image: 'images/volunteer_icon.png',
                              color: Colors.deepOrange,
                              ontap: () {
                                AppNavigation.push(context, MyVolunteerHelp());
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepOrange, // Customize the background color
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'images/profile.jpg', // Replace with your image URL
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _user!.displayName
                        .toString()
                        .toUpperCase(), // Replace with user's name
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(
                'Edit Profile'.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Handle item 1 press
                AppNavigation.push(context, const MyEditProfile());
              },
            ),
            const Divider(
              color: Colors.grey, // Customize the divider color
            ),
            LanguageDropdown(), // Assuming LanguageDropdown is a custom widget
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Logout'.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Handle Logout tap
                AppNavigation.push(context, MySigninScreen());
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void updateCallStatus() {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Specify the collection and document ID
    String collection = 'blind_users';
    String? documentId = _user?.uid;

    // Update the document
    if (checkcall == 1) {
      firestore.collection(collection).doc(documentId).update({
        'brief call': true,
        'extended call': false,
        'call': true,
        'call type': 'brief call'
      }).then((value) {
        print('Document updated successfully.');
      }).catchError((error) {
        print('Failed to update document: $error');
      });
    } else if (checkcall == 2) {
      firestore.collection(collection).doc(documentId).update({
        'extended call': true,
        'call': true,
        'call type': 'extended call',
        'brief call': false
      }).then((value) {
        print('Document updated successfully.');
      }).catchError((error) {
        print('Failed to update document: $error');
      });
    }
  }

  // void getDocumentsData() {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   String collection = 'blind_users';

  //   firestore.collection(collection).get().then((QuerySnapshot snapshot) {
  //     documentsData.clear(); // Clear the previous data
  //     snapshot.docs.forEach((DocumentSnapshot document) {
  //       // Access the data of each document
  //       Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  //       // Add the document data to the list
  //       if ((data['brief call'] == true && data['call'] == true) ||
  //           (data['extended call'] == true && data['call'] == true)) {
  //         // Add the document data to the list
  //         documentsData.add(data);
  //       }
  //     });

  //     // Update the UI to reflect the changes
  //     if (mounted) {
  //       // Only update the UI if the widget is still in the widget tree
  //       // to avoid updating a disposed widget
  //       setState(() {});
  //     }
  //   }).catchError((error) {
  //     print('Failed to retrieve documents: $error');
  //   });
  // }
}
