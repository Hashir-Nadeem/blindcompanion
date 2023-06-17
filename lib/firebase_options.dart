import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYUYlzQHGdPxDit_j3UtJvkqIkNPf8z04',
    appId: '1:276707124771:web:06854fc7045af3b566b396',
    messagingSenderId: '276707124771',
    projectId: 'blind-companion-6e045',
    authDomain: 'blind-companion-6e045.firebaseapp.com',
    storageBucket: 'blind-companion-6e045.appspot.com',
    measurementId: 'G-7LTFWNWRXE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJu80_-QwpCKGrGrAPt-lYeSFt2K8N_II',
    appId: '1:276707124771:android:da4e79776e45d5a966b396',
    messagingSenderId: '276707124771',
    projectId: 'blind-companion-6e045',
    storageBucket: 'blind-companion-6e045.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbTb9YcyFBJeqS-oRNQaiYV5dWbSDpKKk',
    appId: '1:276707124771:ios:225516ae069a6f3f66b396',
    messagingSenderId: '276707124771',
    projectId: 'blind-companion-6e045',
    storageBucket: 'blind-companion-6e045.appspot.com',
    iosClientId:
        '276707124771-celee0fo1pbqc9hdn8t5ruhtaakarh13.apps.googleusercontent.com',
    iosBundleId: 'com.example.blindCompanion',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbTb9YcyFBJeqS-oRNQaiYV5dWbSDpKKk',
    appId: '1:276707124771:ios:211eafcffd5d6ced66b396',
    messagingSenderId: '276707124771',
    projectId: 'blind-companion-6e045',
    storageBucket: 'blind-companion-6e045.appspot.com',
    iosClientId:
        '276707124771-aerfqul73j1apaitj167lat7719jshgh.apps.googleusercontent.com',
    iosBundleId: 'com.example.blindCompanion.RunnerTests',
  );
}
