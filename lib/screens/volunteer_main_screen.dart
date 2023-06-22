import 'dart:async';

import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/blind_call_request_container.dart';
import 'package:blind_companion/components/languageDropdown.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/test_call_screen.dart';
import 'package:blind_companion/screens/videocalling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend.dart/getDocuments.dart';

class MyVolunteerScreen extends StatefulWidget {
  @override
  State<MyVolunteerScreen> createState() => _MyVolunteerScreenState();
}

class _MyVolunteerScreenState extends State<MyVolunteerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showNoCallsText = false;
  List<Map<String, dynamic>> documentsData =
      []; // Declare documentsData as a class member
  List<Map<String, dynamic>> rejectData = [];
  List<int> rejectedIndices = [];
  var uid = null;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchDocumentsData();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        fetchDocumentsData();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchDocumentsData() async {
    try {
      List<Map<String, dynamic>> data = await GetDocuments.getDocumentsData();
      documentsData = data;
      if (documentsData.isEmpty) {
        await Future.delayed(const Duration(seconds: 1));

        showNoCallsText = true;
      } else {
        showNoCallsText = false;
      }
      if (rejectData.isNotEmpty) {
        for (int i = 0; i < rejectData.length; i++) {
          documentsData.remove(rejectData[i]);
        }
      }
    } catch (error) {
      debugPrint('Failed to retrieve documents: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final User? _user = _auth.currentUser;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        leading: Image.asset(
          'images/logo.png',
          fit: BoxFit.cover,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () {
              return fetchDocumentsData();
            },
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    _user?.displayName?.toString().toUpperCase() ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  titleTextStyle: const TextStyle(color: Colors.deepOrange),
                  subtitle: Text(
                    _user?.email?.toString() ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  tileColor: const Color.fromARGB(31, 154, 153, 153),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        shape: BoxShape.rectangle,
                      ),
                      child: TextButton(
                        onPressed: () {
                          AppNavigation.push(context, TestCall());
                        },
                        child: const Text('Learn to answer a call'),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Help Request From Blind'.tr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (documentsData.isEmpty && !showNoCallsText)
                      Container(
                        child: const CircularProgressIndicator(),
                      )
                    else if (documentsData.isEmpty && showNoCallsText)
                      const Text('No calls right now')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: documentsData.length,
                        itemBuilder: (context, index) {
                          if (rejectedIndices.contains(index)) {
                            return Container(); // Return an empty container for rejected items
                          } else {
                            return MyBlindCallRequestContainer(
                              ontap: () {
                                setState(() {
                                  uid = documentsData[index]['uid'];
                                  updateBriefCallStatus();
                                  fetchDocumentsData();
                                });
                                AppNavigation.push(
                                    context,
                                    CallPage(
                                      callID: documentsData[index]['uid'],
                                    ));
                              },
                              ontaprej: () {
                                setState(() {
                                  rejectedIndices.add(
                                      index); // Add the index to rejectedIndices
                                });
                              },
                              text: documentsData[index]['name'],
                              callType: documentsData[index]['call type'],
                              uid: documentsData[index]['uid'],
                            );
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
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

  void updateBriefCallStatus() {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Specify the collection and document ID
    String collection = 'blind_users';
    String? documentId = uid;

    // Update the document based on the call type

    firestore.collection(collection).doc(documentId).update({
      'brief call': false,
      'extended call': false,
      'call': false,
      'call type': null,
    }).then((value) {
      print('Document updated successfully.');
    }).catchError((error) {
      print('Failed to update document: $error');
    });
  }
}
