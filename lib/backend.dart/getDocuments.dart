import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Assets/Navigation.dart';
import '../screens/blind_main_screen.dart';
import '../screens/self_volunteerHelp.dart';
import '../screens/volunteer_main_screen.dart';
import 'auth_service.dart';
export 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDocuments {
  static Future<List<Map<String, dynamic>>> getDocumentsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedlang = prefs.getString('selectedlang');
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String collection = 'blind_users';
    print('Selected Language' + '$selectedlang');

    List<Map<String, dynamic>> documentsData = [];

    try {
      QuerySnapshot snapshot = await firestore.collection(collection).get();

      snapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        print('coming Language' + '${data['language']}');
        if ((data['brief call'] == true &&
                data['call'] == true &&
                data['language'] == selectedlang.toString()) ||
            (data['extended call'] == true &&
                data['call'] == true &&
                data['language'] == selectedlang.toString())) {
          documentsData.add(data);
        }
      });
      print(documentsData);

      return documentsData;
    } catch (error) {
      debugPrint('Failed to retrieve documents: $error');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getBlindData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String collection = 'blind_users';

    List<Map<String, dynamic>> documentsData = [];

    try {
      QuerySnapshot snapshot = await firestore.collection(collection).get();

      for (var document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        documentsData.add(data);
      }

      return documentsData;
    } catch (error) {
      debugPrint('Failed to retrieve documents: $error');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getVolunteerData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String collection = 'volunteer_users';

    List<Map<String, dynamic>> documentsData = [];

    try {
      QuerySnapshot snapshot = await firestore.collection(collection).get();

      snapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        documentsData.add(data);
      });
      return documentsData;
    } catch (error) {
      debugPrint('Failed to retrieve documents: $error');
      return [];
    }
  }

  static Future<bool> signInWithGoogle(BuildContext context) async {
    var isSuccess = false;
    try {
      // getting google user
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // taking google auth with the authentication
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth == null) {
        isSuccess = false;
        return isSuccess;
      }
      // taking the credential of the user
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, // accessToken from google auth
        idToken: googleAuth.idToken, // idToken from google auth
      );

      // user credential to use the firebase credential and sign in with the google account
      // also after this line of code the data will be reflected in the fireStore database
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection(turn == 1 ? 'blind_users' : "volunteer_users")
            .doc(user.uid)
            .get()
            .then((userDoc) async {
          GetDocuments.getDocumentsData();
          if (userDoc.exists) {
            isSuccess = true;
          } else {
            isSuccess = true;
            await setData(user);
          }
        }).catchError((e) {
          isSuccess = false;
          Fluttertoast.showToast(
            msg: e.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        });
      } else {
        isSuccess = false;
        return isSuccess;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("erorrdebugPrint FirebaseAuthException => ${e.message!}");
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      isSuccess = false;
      debugPrint("erorrdebugPrint PlatformException => ${e.message!}");
    }
    return isSuccess;
  }

  static Future<void> setData(User user) async {
    if (turn == 1) {
      // Add user to blind_users collection
      await FirebaseFirestore.instance
          .collection('blind_users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'call': false,
        'brief call': false,
        'extended call': false,
        'call type': null,
        'language': "en US"
      });
    } else if (turn == 2) {
      // Add user to volunteer_users collection
      await FirebaseFirestore.instance
          .collection('volunteer_users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'language': "en US"
      });
    }
  }

  static Future<bool> signInWithApple(BuildContext context) async {
    var isSuccess = false;
    try {
      final authService = AuthService();

      final userCredential = await authService.signInWithApple();
      final user = userCredential.user!;
      await FirebaseFirestore.instance
          .collection(turn == 1 ? 'blind_users' : "volunteer_users")
          .doc(user.uid)
          .get()
          .then((userDoc) async {
        GetDocuments.getDocumentsData();
        if (userDoc.exists) {
          isSuccess = true;
        } else {
          isSuccess = true;
          await setData(user);
        }
      }).catchError((e) {
        isSuccess = false;
        Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      });
      debugPrint('uid: ${user.uid}');
    } catch (e) {
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      isSuccess = false;
    }
    return isSuccess;
  }

  // Function to load stored email
  static Future<String?> loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    return storedEmail;
  }

// Function to load stored password
  static Future<String?> loadPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString('password');
    return storedPassword;
  }

  // Function to save email
  static Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

// Function to save password
  static Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }
}
