import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithApple({List<Scope> scopes = const [Scope.email, Scope.fullName]}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
       final firebaseUser = userCredential.user!;
        final fullName = appleIdCredential.fullName;

        if (scopes.contains(Scope.fullName)) {

          debugPrint("=============${fullName?.familyName.toString()}");
          debugPrint("=============${fullName?.givenName.toString()}");
          debugPrint("=============${fullName?.nickname.toString()}");
          debugPrint("=============${appleIdCredential.email.toString()}=============");

          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {

            final displayName = '${fullName.givenName} ${fullName.familyName}';
            debugPrint("============$displayName");
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return userCredential;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }
}
