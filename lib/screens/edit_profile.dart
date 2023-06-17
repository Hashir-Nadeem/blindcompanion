import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Assets/Navigation.dart';
import 'blind_main_screen.dart';
import 'self_volunteerHelp.dart';

class MyEditProfile extends StatelessWidget {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // Add formKey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile'.tr,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey, // Assign formKey to the Form widget
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
                    height: 10,
                  ),
                  MyTextField(
                    hint: 'Email Address'.tr,
                    prefixIcon: const Icon(Icons.email_outlined),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    height: 10,
                  ),
                  MyTextField(
                    hint: 'Old Password'.tr,
                    prefixIcon: const Icon(Icons.password_outlined),
                    controller: oldPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hint: 'New Password'.tr,
                    prefixIcon: const Icon(Icons.password_outlined),
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hint: 'Confirm Password'.tr,
                    prefixIcon: const Icon(Icons.password_outlined),
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm you password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          MyTextButton(
            text: 'Save'.tr,
            color: Colors.deepOrange,
            ontap: () {
              if (formKey.currentState!.validate()) {
                if (turn == 2) {
                  AppNavigation.push(context, MyVolunteerScreen());
                }
                if (turn == 1) {
                  AppNavigation.push(context, MyBlindScreen());
                }
              }
            },
          ),
        ],
      ),
    );
  }

  bool isEmailValid(String email) {
    // Simple email validation using a regular expression pattern
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
