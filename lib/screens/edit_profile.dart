import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Assets/Navigation.dart';
import 'blind_main_screen.dart';
import 'self_volunteerHelp.dart';

class MyEditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
            child: Column(
              children: [
                MyTextField(hint: 'Name'.tr, label: 'Name'.tr),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    hint: 'Email Address'.tr, label: 'Email Address'.tr),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(hint: 'Old Password'.tr, label: 'Old Password'.tr),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(hint: 'New Password'.tr, label: 'New Password'.tr),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    hint: 'Confirm Password'.tr, label: 'Confirm Password'.tr),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          MyTextButton(
            text: 'Save'.tr,
            color: Colors.deepOrange,
            ontap: () {
              if (turn == 2) {
                AppNavigation.push(context, MyVolunteerScreen());
              }
              if (turn == 1) {
                AppNavigation.push(context, MyBlindScreen());
              }
            },
          )
        ],
      ),
    ));
  }
}
