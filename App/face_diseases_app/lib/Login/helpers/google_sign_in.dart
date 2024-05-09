/*import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routing/routes.dart';
import 'extensions.dart';

class GoogleSignin {
  static final _auth = FirebaseAuth.instance;

  static Future signInWithGoogle(BuildContext context) async {
    try {
      
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

    
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

    
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        await _auth.currentUser!.delete();
        if (!context.mounted) return;
        context.pushNamedAndRemoveUntil(
          Routes.createPassword,
          predicate: (route) => false,
          arguments: [googleUser, credential],
        );
      } else {
        if (!context.mounted) return;
        context.pushNamedAndRemoveUntil(
          Routes.homeScreen,
          predicate: (route) => false,
        );
      }
    } catch (e) {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Sign in error',
        desc: e.toString(),
      ).show();
    }
  }
}
*/

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routing/routes.dart';
import 'extensions.dart';

class GoogleSignin {
  static final _auth = FirebaseAuth.instance;

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      print("Attempting to sign in with Google...");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        print("User cancelled the Google sign-in process.");
        return;
      }

      print("Google sign-in successful, retrieving authentication...");
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      print("Creating GoogleAuthProvider credential...");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print("Signing in with credential...");
      final UserCredential authResult = await _auth.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        print("New user detected, deleting user and navigating to createPassword...");
        await _auth.currentUser!.delete();
        if (!context.mounted) return;
        context.pushNamedAndRemoveUntil(
          Routes.createPassword,
          predicate: (route) => false,
          arguments: [googleUser, credential],
        );
      } else {
        print("Existing user, navigating to homeScreen...");
        if (!context.mounted) return;
        context.pushNamedAndRemoveUntil(
          Routes.homeScreen,
          predicate: (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      // Specific Firebase Auth errors
      print("FirebaseAuthException occurred: ${e.code}");
      String message = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          message = 'This account exists with a different sign-in provider.';
          break;
        case 'invalid-credential':
          message = 'The provided credential is malformed or has expired.';
          break;
        case 'operation-not-allowed':
          message = 'This sign-in method is not enabled.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'user-not-found':
          message = 'No user found for the given credentials.';
          break;
        case 'wrong-password':
          message = 'The password is invalid.';
          break;
        default:
          message = 'An undefined Error happened.';
      }
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Sign in error',
        desc: message,
      ).show();
    } catch (e) {
      // Generic errors
      final errorMessage = "Error during Google Sign-In: $e";
      print(errorMessage);
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Sign in error',
        desc: 'An error occurred during sign-in. Please try again.\nError: $errorMessage',
      ).show();
    }
  }
}
