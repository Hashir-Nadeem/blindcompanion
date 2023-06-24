import 'package:the_apple_sign_in/the_apple_sign_in.dart';

final appleSignInAvailable = AppleSignInAvailable();

class AppleSignInAvailable {
  var isAvailable = false;
  Future<bool> check() async {
    isAvailable = await TheAppleSignIn.isAvailable();
    return isAvailable;
  }
}
