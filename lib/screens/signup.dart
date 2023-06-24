import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Assets/Navigation.dart';

class MySignupScreen extends StatefulWidget {
  @override
  State<MySignupScreen> createState() => _MySignupScreenState();
}

class _MySignupScreenState extends State<MySignupScreen> {
  bool _isChecked = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 243, 239),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: Image.asset('images/logo.png'),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextField(
                          hint: 'Name'.tr,
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          hint: 'Email Address'.tr,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email_outlined),
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
                          height: 20,
                        ),
                        MyTextField(
                          hint: 'Password'.tr,
                          obscure: true,
                          controller: passwordController,
                          prefixIcon: const Icon(Icons.password_outlined),
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
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'By creating account you\'re accepting terms and conditions'
                              .tr,
                          style: TextStyle(fontSize: screenWidth * 0.03),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MyTextButton(
                    text: 'Sign Up'.tr,
                    color: Colors.deepOrange,
                    ontap: () {
                      if (formKey.currentState!.validate()) {
                        if (!_isChecked) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Please accept the terms and conditions'),
                              actions: <Widget>[
                                MyTextButton(
                                  color: Colors.deepOrange,
                                  ontap: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'OK',
                                ),
                              ],
                            ),
                          );
                          return;
                        } else {
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString())
                              .then((value) {
                            final user = value.user;
                            user?.updateDisplayName(nameController.text);

                            if (turn == 1) {
                              // Add user to blind_users collection
                              _firestore
                                  .collection('blind_users')
                                  .doc(user?.uid)
                                  .set({
                                'uid': user?.uid,
                                'name': nameController.text,
                                'email': user?.email,
                                'call': false,
                                'brief call': false,
                                'extended call': false,
                                'call type': null
                              });
                            } else if (turn == 2) {
                              // Add user to volunteer_users collection
                              _firestore
                                  .collection('volunteer_users')
                                  .doc(user?.uid)
                                  .set({
                                'uid': user?.uid,
                                'name': nameController.text,
                                'email': user?.email,
                              });
                            }

                            Fluttertoast.showToast(
                              msg: 'Sign up successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                            AppNavigation.push(context, MySigninScreen());
                          }).catchError((error) {
                            Fluttertoast.showToast(
                              msg: error.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          });
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
