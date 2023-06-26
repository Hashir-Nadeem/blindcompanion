import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

import 'blind_main_screen.dart';

class VideoCalling extends StatefulWidget {
  const VideoCalling({Key? key}) : super(key: key);

  @override
  State<VideoCalling> createState() => _VideoCallingState();
}

final String localUserID = math.Random().nextInt(10000).toString();

class _VideoCallingState extends State<VideoCalling> {
  final callIDTextCtrl = TextEditingController(text: "call_id");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: callIDTextCtrl,
                  decoration:
                      const InputDecoration(labelText: "join a call by id"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return CallPage(callID: callIDTextCtrl.text);
                    }),
                  );
                },
                child: const Text("join"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CallPage extends StatefulWidget {
  final callID;

  CallPage({
    Key? key,
    required this.callID,
  }) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  User? _user;
  Timer? _callTimer;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;

    if (isBriefCall) {
      // Start the call timer only for brief help call
      _callTimer = Timer(Duration(seconds: 15), () {
        endCallAutomatically();
      });
    }
  }

  @override
  void dispose() {
    // Cancel the call timer when the widget is disposed
    _callTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ZegoUIKitPrebuiltCall(
      appID: 646391929,
      appSign:
          '4fc04bda50567666c3bee6a781cfe490c3ce7af9ac5f13da0decbf1900803e55',
      userID: localUserID,
      userName: "user_$localUserID",
      callID: widget.callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onHangUp = () {
          // Cancel the call timer when the call is manually ended
          _callTimer?.cancel();
          updateBriefCallStatus();

          Navigator.of(context).pop();
        }
        ..onOnlySelfInRoom = (context) {
          // Cancel the call timer when there is only the current user in the room
          _callTimer?.cancel();
          Navigator.of(context).pop();
        },
    ));
  }

  void updateBriefCallStatus() {
    // Get the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Specify the collection and document ID
    String collection = 'blind_users';
    String? documentId = widget.callID;

    // Update the document based on the call type
    if (isBriefCall) {
      firestore.collection(collection).doc(documentId).update({
        'brief call': false,
        'extended call': false,
        'call': false,
        'call type': null,
      }).then((value) {
        print('Document updated successfully.');
      }).catchError((error) {
        print('Failed to update document: $error');
      });
    } else {
      firestore.collection(collection).doc(documentId).update({
        'brief call': false,
        'extended call': false,
        'call': false,
        'call type': null,
      }).then((value) {
        print('Document updated successfully.');
      }).catchError((error) {
        print('Failed to update document: $error');
      });
    }
  }

  void endCallAutomatically() {
    // End the call automatically
    updateBriefCallStatus();
    Navigator.of(context).pop();
  }
}
