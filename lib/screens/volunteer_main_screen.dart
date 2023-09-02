import 'dart:async';

import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/blind_call_request_container.dart';
import 'package:blind_companion/components/languageDropdown.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/test_call_screen.dart';
import 'package:blind_companion/screens/videocalling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend.dart/getDocuments.dart';
import '../components/textbutton.dart';
import '../theme.dart';

class MyVolunteerScreen extends StatefulWidget {
  const MyVolunteerScreen({super.key});

  @override
  State<MyVolunteerScreen> createState() => _MyVolunteerScreenState();
}

class _MyVolunteerScreenState extends State<MyVolunteerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showNoCallsText = false;
  List<Map<String, dynamic>> documentsData = []; // Declare documentsData as a class member
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        automaticallyImplyLeading: false,
        title: Image.asset("images/new_logo.png"),
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () {
              return fetchDocumentsData();
            },
            child: Column(
              children: [
                notificationContainer(context, screenHeight, screenWidth),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                globeContainer(context, screenHeight, screenWidth),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                personContainer(context, screenHeight, screenWidth, _user),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: buildDrawer(_user, context),
    );
  }

  Drawer buildDrawer(User? user, BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: buttonColor, // Customize the background color
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
                  user!.displayName
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
              Navigator.pop(context);
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
              // _auth.signOut();
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => MySelfVolunteerHelp()),
              //     ModalRoute.withName("/Home"));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // void updateBriefCallStatus() {
  //   // Get the Firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   // Specify the collection and document ID
  //   String collection = 'blind_users';
  //   String? documentId = uid;
  //
  //   // Update the document based on the call type
  //
  //   firestore.collection(collection).doc(documentId).update({
  //     'brief call': false,
  //     'extended call': false,
  //     'call': false,
  //     'call type': null,
  //   }).then((value) {
  //     print('Document updated successfully.');
  //   }).catchError((error) {
  //     print('Failed to update document: $error');
  //   });
  // }

  Widget notificationContainer(BuildContext context, double screenHeight, double screenWidth){
    return InkWell(
      onTap: (){

      },
      child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  child: Image.asset("images/bell.png",
                      fit: BoxFit.cover,
                      height: screenHeight * 0.035
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Allow notification".tr,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                      Text("Allow notifications in order to receive calls when someone needs your help.".tr, style: const TextStyle(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget globeContainer(BuildContext context, double screenHeight, double screenWidth){
    return Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                child: Image.asset("images/White_Globe_Icon.png",
                    fit: BoxFit.cover,
                    height: 120
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCounterRow("Blind", 10000),
                  buildCounterRow("Volunteers", 1000),
                ],
              ),
            //  buildRow("522,575\nBlind", "6,858,788\nVolunteers")
            ],
          ),
        )
    );
  }

  Column buildCounterRow(String typeText, double countText) {
    return Column(
      children: [
        Countup(
          begin: 0,
          // end: blindData.length * 1.0,
          end: countText,
          duration: const Duration(seconds: 3),
          separator: ',',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            typeText,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget personContainer(BuildContext context, double screenHeight, double screenWidth, User? user){
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Colors.black,
              width: 2
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(user?.displayName.toString() ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              Text(user?.email.toString() ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
    );
  }
}
