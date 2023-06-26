import 'dart:async';

import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/videocalling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend.dart/getDocuments.dart';
import '../components/blind_call_request_container.dart';
import 'blind_main_screen.dart';
import 'call.dart';

class MyVolunteerHelp extends StatefulWidget {
  const MyVolunteerHelp({super.key});

  @override
  State<MyVolunteerHelp> createState() => _MyVolunteerHelpState();
}

class _MyVolunteerHelpState extends State<MyVolunteerHelp> {
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
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
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
                                          'Your request for brief help call is submitted successfully. You will be notified shortly'
                                              .tr,
                                        ),
                                      ]),
                                    );
                                  },
                                );
                                isBriefCall = true;

                                // Delay the navigation to the next screen
                                Timer(const Duration(seconds: 3), () {
                                  checkcall = 1;
                                  updateCallStatus();
                                  GetDocuments.getDocumentsData();
                                  AppNavigation.push(
                                      context, CallPage(callID: _user?.uid));
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
                                          'Your request for extended help call is submitted successfully. You will be notified shortly'
                                              .tr,
                                        ),
                                      ]),
                                    );
                                  },
                                );
                                isBriefCall = false;

                                // Delay the navigation to the next screen
                                Timer(const Duration(seconds: 3), () {
                                  checkcall = 2;
                                  updateCallStatus();
                                  GetDocuments.getDocumentsData();
                                  AppNavigation.push(
                                      context, CallPage(callID: _user?.uid));
                                });
                              },
                            ),
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
}
