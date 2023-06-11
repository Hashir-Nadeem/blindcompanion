import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/trace_me_OCR.dart';
import 'package:blind_companion/screens/volunteer_help.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBlindScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  MyBlindScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Volunteer'.tr,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              titleTextStyle: const TextStyle(color: Colors.deepOrange),
              subtitle: Text(
                'emmanuelpriest@gmail.com'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black),
              ),
              tileColor: const Color.fromARGB(31, 154, 153, 153),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Discover the Community. See the World Together'.tr,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 30,
                  ),
                  MyDoubleIconTextButton(
                    text: 'Self Help'.tr,
                    image: 'images/self_help_icon.png',
                    color: Colors.deepOrange,
                    ontap: () {
                      AppNavigation.push(context, MyTraceMeOcr());
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyDoubleIconTextButton(
                    text: 'Self/Volunteer Help'.tr,
                    image: 'images/volunteer_icon.png',
                    color: Colors.deepOrange,
                    ontap: () {
                      AppNavigation.push(context, MyVolunteerHelp());
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    'Volunteer'.tr,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'emmanuelpriest@gmail.com'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text('Edit Profile'.tr),
              onTap: () {
                // Handle item 1 press
                AppNavigation.push(context, MyEditProfile());
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout'.tr),
              onTap: () {
                // Handle item 2 press
                AppNavigation.push(context, MySigninScreen());
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
