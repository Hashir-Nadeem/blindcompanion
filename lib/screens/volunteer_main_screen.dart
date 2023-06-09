import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/components/blind_call_request_container.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:flutter/material.dart';

class MyVolunteerScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  MyVolunteerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
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
              icon: const Icon(Icons.menu))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                AppTexts.volunteer,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              titleTextStyle: const TextStyle(color: Colors.deepOrange),
              subtitle: Text(
                AppTexts.volunteer_email,
                style: TextStyle(
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
                  Row(
                    children: [
                      Text(
                        AppTexts.help_request,
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
                  const MyBlindCallRequestContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  const MyBlindCallRequestContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  const MyBlindCallRequestContainer(),
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
                    AppTexts.volunteer,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    AppTexts.volunteer_email,
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
              title: Text(AppTexts.edit_profile),
              onTap: () {
                // Handle item 1 press
                AppNavigation.push(context, MyEditProfile());
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(AppTexts.logout),
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
