import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:flutter/material.dart';

import '../Assets/Navigation.dart';
import 'blind_main_screen.dart';
import 'self_volunteerHelp.dart';

class MyEditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.edit_profile,
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
                MyTextField(hint: AppTexts.name, label: AppTexts.name),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    hint: AppTexts.email_address,
                    label: AppTexts.email_address),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(hint: AppTexts.old_pwd, label: AppTexts.old_pwd),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(hint: AppTexts.new_pwd, label: AppTexts.new_pwd),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(hint: AppTexts.cfm_pwd, label: AppTexts.cfm_pwd),
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
            text: AppTexts.save,
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
