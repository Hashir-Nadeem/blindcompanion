import 'package:blind_companion/backend.dart/getDocuments.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/blind_main_screen.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Assets/Navigation.dart';

bool isLoggedIn = false;

class MySigninScreen extends StatefulWidget {
  @override
  _MySigninScreenState createState() => _MySigninScreenState();
}

class _MySigninScreenState extends State<MySigninScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  late List<Map<String, dynamic>> blindData = [];
  late List<Map<String, dynamic>> volunteerData = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    GetDocuments.getBlindData().then((data) {
      setState(() {
        blindData = data;
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
    final screenWidth = screenSize.width;
    // Check if the user is already authenticated
    if (_auth.currentUser != null && !isLoggedIn) {
      // User is already signed in, update the isLoggedIn variable
      Future.delayed(Duration.zero, () {
        setState(() {
          isLoggedIn = true;
        });

        // Navigate to the appropriate screen based on the turn value
        if (turn == 2) {
          GetDocuments.getDocumentsData();
          AppNavigation.push(context, MyVolunteerScreen());
        } else if (turn == 1) {
          AppNavigation.push(context, MyBlindScreen());
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 248, 243, 239),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: const Color.fromARGB(255, 248, 243, 239),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset('images/logo.png'),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        hint: 'Email Address'.tr,
                        prefixIcon: const Icon(Icons.email_outlined),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!isEmailValid(value)) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                        hint: 'Password'.tr,
                        prefixIcon: const Icon(Icons.password_outlined),
                        obscure: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        _resetPassword();
                      },
                      child: Text(
                        'Forget Password?'.tr,
                        style: const TextStyle(
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextButton(
                  text: 'Sign In'.tr,
                  color: Colors.deepOrange,
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      final credential = EmailAuthProvider.credential(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                      );

                      _auth.signInWithCredential(credential).then((value) {
                        // Sign-in successful
                        setState(() {
                          isLoggedIn = true;
                        });
                        String language;
                        if (turn == 2) {
                          DocumentReference docRef = firestore
                              .collection('volunteer_users')
                              .doc(value.user?.uid);

                          docRef.get().then((DocumentSnapshot snapshot) {
                            if (snapshot.exists) {
                              // Document exists, you can access its data using snapshot.data()
                              var data = snapshot.data();
                              // Process the data as needed
                              //fetch language and then compare it with locale
                              /*if (language == 'ur PK') {
                              var locale = const Locale('ur', 'PK');
                              Get.updateLocale(locale);
                            } else if (language == 'en US') {
                              var locale = const Locale('en', 'US');
                              Get.updateLocale(locale);
                            }*/

                              print(data);
                            } else {
                              // Document does not exist
                              print('Document does not exist');
                            }
                          }).catchError((error) {
                            print('Error getting document: $error');
                          });

                          GetDocuments.getDocumentsData();
                          AppNavigation.push(context, MyVolunteerScreen());
                        }
                        if (turn == 1) {
                          DocumentReference docRef = firestore
                              .collection('blind_users')
                              .doc(value.user?.uid);

                          docRef.get().then((DocumentSnapshot snapshot) {
                            if (snapshot.exists) {
                              // Document exists, you can access its data using snapshot.data()
                              var data = snapshot.data();
                              // Process the data as needed
                              //fetch language and then compare it with locale
                              /*if (language == 'ur PK') {
                              var locale = const Locale('ur', 'PK');
                              Get.updateLocale(locale);
                            } else if (language == 'en US') {
                              var locale = const Locale('en', 'US');
                              Get.updateLocale(locale);
                            }*/

                              print(data);
                            } else {
                              // Document does not exist
                              print('Document does not exist');
                            }
                          }).catchError((error) {
                            print('Error getting document: $error');
                          });

                          /*Update the locale based on the retrieved language
                            if (language == 'ur PK') {
                              var locale = const Locale('ur', 'PK');
                              Get.updateLocale(locale);
                            } else if (language == 'en US') {
                              var locale = const Locale('en', 'US');
                              Get.updateLocale(locale);
                            }*/

                          AppNavigation.push(context, MyBlindScreen());
                        }
                      }).catchError((error) {
                        // Sign-in error
                        Fluttertoast.showToast(
                          msg: error.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Don\'t have an account?'.tr,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        AppNavigation.push(context, MyEmailScreen());
                      },
                      child: Text('Sign Up'.tr),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    // Simple email validation using a regular expression pattern
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void _resetPassword() async {
    final String email = emailController.text.trim();

    try {
      await _auth.sendPasswordResetEmail(email: email);

      Fluttertoast.showToast(
        msg: 'Please Check Your Mail',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Must Enter Your Email',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
