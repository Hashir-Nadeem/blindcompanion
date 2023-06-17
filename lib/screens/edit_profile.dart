import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Assets/Navigation.dart';
import 'blind_main_screen.dart';
import 'self_volunteerHelp.dart';
import 'signIn.dart';
import '../components/textbutton.dart';
import '../components/textfield.dart';

class MyEditProfile extends StatefulWidget {
  @override
  _MyEditProfileState createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<MyEditProfile> {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    nameController.text = _user?.displayName ?? '';
    emailController.text = _user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 30),
                MyTextField(
                  hint: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hint: 'Email Address',
                  prefixIcon: const Icon(Icons.email_outlined),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hint: 'Old Password',
                  prefixIcon: const Icon(Icons.password_outlined),
                  controller: oldPasswordController,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hint: 'New Password',
                  prefixIcon: const Icon(Icons.password_outlined),
                  controller: newPasswordController,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hint: 'Confirm Password',
                  prefixIcon: const Icon(Icons.password_outlined),
                  obscure: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 5),
                MyTextButton(
                  text: 'Save',
                  color: Colors.deepOrange,
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      updateProfile();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final displayName = nameController.text;
      final email = emailController.text;
      final password = newPasswordController.text;
      final credential = EmailAuthProvider.credential(
        email: _user?.email ?? '',
        password: oldPasswordController.text,
      );

      if (password.isNotEmpty) {
        await _user?.reauthenticateWithCredential(credential);
        await _user?.updatePassword(password);
      }

      if (displayName != _user!.displayName) {
        await _user?.updateDisplayName(displayName).then((value) => null);
      }
      if (email != _user!.email) {
        await _user?.updateEmail(email);
      }
      Fluttertoast.showToast(
        msg: 'Profile Updated Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      AppNavigation.push(context, MySigninScreen());
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isEmailValid(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
