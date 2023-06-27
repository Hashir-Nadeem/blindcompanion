import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                data['language'] == selectedlang) ||
            (data['extended call'] == true &&
                data['call'] == true &&
                data['language'] == selectedlang)) {
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
}
