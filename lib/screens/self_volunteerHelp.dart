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
import '../theme.dart';
import 'blind_main_screen.dart';

int turn = 0;

class MySelfVolunteerHelp extends StatefulWidget {
  const MySelfVolunteerHelp({super.key});

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
        });
      }).catchError((error) {
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return (Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Image.asset("images/new_logo.png"),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: buildBody(screenHeight, context),
            ),
            isLoading
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                        color: buttonColor,
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

  Column buildBody(double screenHeight, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: 15.0),
          child: Text(
            'Discover the Community. See the World Together'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )),
        Image.asset("images/Group1.png"),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildCounterRow("Blind", blindData.length * 1.0),
            buildCounterRow("Volunteers", volunteerData.length * 1.0),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        MyDoubleIconTextButton(
          text: 'I am a Blind'.tr,
          isIconRequired: false,
          isLeadingImageRequired: false,
          color: Colors.deepOrange,
          ontap: () async {
            turn = 1;
            storeSelectedRole('Blind');
            if (_auth.currentUser != null) {
              GetDocuments.getDocumentsData();
              await storeSelectedlang();
              AppNavigation.push(
                  context, MySigninScreen());
              // AppNavigation.push(
              //     context, MyBlindScreen());
            } else {
              AppNavigation.push(
                  context, MyWelcomeScreen());
            }
          },
          desc: 'Call a company or Volunteer'.tr,
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        MyDoubleIconTextButton(
          text: 'I am a Volunteer'.tr,
          isIconRequired: false,
          isLeadingImageRequired: false,
          color: Colors.deepOrange,
          ontap: () async {
            turn = 2;
            storeSelectedRole('Volunteer');
            if (_auth.currentUser != null) {
              GetDocuments.getDocumentsData();
              await storeSelectedlang();
              AppNavigation.push(
                  context, MySigninScreen());
              // AppNavigation.push(
              //     context, MyVolunteerScreen());
            } else {
              AppNavigation.push(
                  context, MyWelcomeScreen());
            }
          },
          desc: 'Share your eyesight'.tr,
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
      ],
    );
  }
  Column buildCounterRow(String typeText, double countText) {
    return Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              typeText,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Countup(
            begin: 0,
            end: countText,
            duration: const Duration(seconds: 3),
            separator: ',',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
  }
}
