import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<UserCredential?> signInWithApple() async {
    try {
      // Note: For Android, Sign in with Apple uses a web flow and requires service configuration.
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final oauthCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      return await _auth.signInWithCredential(oauthCredential);
    } catch (e) {
      // In prototype, swallow and return null
      return null;
    }
  }

  Future<void> signOut() => _auth.signOut();
}
