import 'package:blind_companion/backend.dart/getDocuments.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/blind_main_screen.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:blind_companion/screens/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assets/Navigation.dart';
import '../components/double_icontextButton.dart';
import 'package:blind_companion/backend.dart/apple_sign_in_available.dart';

import '../theme.dart';

bool isLoggedIn = false;
String? lang;

class MySigninScreen extends StatefulWidget {
  const MySigninScreen({super.key});

  @override
  _MySigninScreenState createState() => _MySigninScreenState();
}

class _MySigninScreenState extends State<MySigninScreen> {
  final emailController = TextEditingController();
  String? storedEmail, storedPassword;
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late FirebaseAuth? _auth = FirebaseAuth.instance;
  late List<Map<String, dynamic>> blindData = [];
  late List<Map<String, dynamic>> volunteerData = [];
   var isLoading = false;
   var isBottomSheetLoading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> loadStoredCredentials() async {
    storedEmail = await GetDocuments.loadEmail(); // Implement loadEmail() to retrieve the stored email
    print("Email is : $storedEmail");// Implement loadEmail() to retrieve the stored email
    storedPassword = await GetDocuments.loadPassword();
    print("Email is : $storedPassword"); // Implement loadPassword() to retrieve the stored password
    emailController.text = storedEmail ?? '';
    passwordController.text = storedPassword ?? '';
  }

  @override
  void initState() {
    super.initState();
   _auth = FirebaseAuth.instance;
    loadStoredCredentials();
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
    // if (_auth.currentUser != null && !isLoggedIn) {
    //   // User is already signed in, update the isLoggedIn variable
    //   Future.delayed(Duration.zero, () {
    //     setState(() {
    //       isLoggedIn = true;
    //       print("Email is ${emailController.text}");
    //       loadStoredCredentials();
    //     });
    //
    //     //TODO: I am commenting this part just to make sure everything working smoothly when this screen loads.
    //     //
    //     // // Navigate to the appropriate screen based on the turn value
    //     // if (turn == 2) {
    //     //   GetDocuments.getDocumentsData();
    //     //   AppNavigation.push(context, MyVolunteerScreen());
    //     // } else if (turn == 1) {
    //     //   AppNavigation.push(context, MyBlindScreen());
    //     // }
    //   });
    // }
    // emailController.text = storedEmail ?? 'Help';
    // passwordController.text = storedPassword ?? 'Me';
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar:  AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Image.asset("images/new_logo.png"),
        centerTitle: true,
        backgroundColor: primaryBackgroundColor,
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return const MyWelcomeScreen();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Aligns children to the start of the row
                    children: [
                      const Icon(Icons.arrow_back_ios_sharp, size: 16),
                      const SizedBox(
                        width: 2,
                      ),
                      Text('Back'.tr,style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                    ],
                  ),
                ),
                Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Center(
                          child: Text("Sign In with Email".tr,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text("Email".tr, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        MyTextField(
                          isSignInScreen: true,
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
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Text("Password".tr, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        MyTextField(
                          isSignInScreen: true,
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              settingModalBottomSheet(context, screenHeight);
                            },
                            child: Text(
                              'Try another way'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                buildColumn(context, screenHeight),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void storeSelectedlang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedlang', lang);
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
    await _auth?.sendPasswordResetEmail(email: email);

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

  Column buildColumn(BuildContext context, double screenHeight) {
    return Column(
      children: [
        MyTextButton(
          text: "Next" .tr,
          color: primaryButtonColor,
          ontap: () {
            if (formKey.currentState!.validate()) {
              final credential = EmailAuthProvider.credential(
                email: emailController.text.toString(),
                password: passwordController.text.toString(),
              );
              _auth?.signInWithCredential(credential).then((value) {
                // Sign-in successful
                setState(() {
                  isLoggedIn = true;
                });
                if (turn == 2) {
                  DocumentReference docRef = firestore
                      .collection('volunteer_users')
                      .doc(_auth?.currentUser!.uid);
                  print('hello' + '${_auth?.currentUser!.uid}');

                  docRef.get().then((DocumentSnapshot snapshot) {
                    if (snapshot.exists) {
                      // Document exists, you can access its data using snapshot.data()
                      var data = (snapshot.data()
                          as Map<String, dynamic>)['language'];
                      lang = data;
                      storeSelectedlang(data);

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

                  GetDocuments.getDocumentsData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const MyVolunteerScreen();
                  }));
                }
                if (turn == 1) {
                  DocumentReference docRef = firestore
                      .collection('blind_users')
                      .doc(_auth?.currentUser!.uid);

                  docRef.get().then((DocumentSnapshot snapshot) {
                    if (snapshot.exists) {
                      // Document exists, you can access its data using snapshot.data()
                      var data = (snapshot.data()
                          as Map<String, dynamic>)['language'];
                      lang = data;
                      storeSelectedlang(data);

                      // Process the data as needed
                      //fetch language and then compare it with locale
                      if (data == 'ur PK') {
                        var locale = const Locale('ur', 'PK');
                        Get.updateLocale(locale);
                      } else if (data == 'en US') {
                        var locale = const Locale('en', 'US');
                        Get.updateLocale(locale);
                      }

                      print(data);
                    } else {
                      // Document does not exist
                      print('Document does not exist');
                    }
                  }).catchError((error) {
                    print('Error getting document: $error');
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return MyBlindScreen();
                  }));
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
        SizedBox(
          height: screenHeight * 0.02,
        ),
        MyTextButton(
          isBorderEnabled: true,
          text: 'Forget Password'.tr,
          color: Colors.transparent,
          ontap: () {
            _resetPassword();
          },
        ),
      ],
    );
  }

  void navigate(BuildContext context) {
    if (turn == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MyVolunteerScreen();
      }));
    }
    if (turn == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyBlindScreen();
      }));
    }
  }

  void settingModalBottomSheet(context, screenHeight) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Container(
              child: isLoading
                  ? const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: buttonColor,
                      strokeWidth: 3,
                    ),
                  ))
                  : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyDoubleIconTextButton(
                    text: 'Continue with Google',
                    image: 'images/g_icon.png',
                    isIconRequired: false,
                    color: buttonColor,
                    ontap: () async {
                      setState(() {
                        isBottomSheetLoading = true;
                      });
                      if (await GetDocuments.signInWithGoogle(
                          context)) {
                        setState(() {
                          isBottomSheetLoading = false;
                        });
                        navigate(context);
                      } else {
                        setState(() {
                          isBottomSheetLoading = false;
                        });
                      }
                    },
                  ),
                  appleSignInAvailable.isAvailable
                      ?
                  SizedBox(
                    height: screenHeight * 0.02,
                  ) :
                  const SizedBox.shrink(),
                  appleSignInAvailable.isAvailable
                      ?
                  MyDoubleIconTextButton(
                    text: 'Continue with Apple',
                    image: 'images/appleLogo.png',
                    isIconRequired: false,
                    color: buttonColor,
                    ontap: () async {
                      setState(() {
                        isBottomSheetLoading = true;
                      });
                      if (await GetDocuments.signInWithApple(
                          context)) {
                        setState(() {
                          isBottomSheetLoading = false;
                        });
                        navigate(context);
                      } else {
                        setState(() {
                          isBottomSheetLoading = false;
                        });
                      }
                    },
                  )
                      : Container(),
                  appleSignInAvailable.isAvailable
                      ? const SizedBox(
                    height: 10,
                  ) : Container(),
                ])),
          );
        });}}
