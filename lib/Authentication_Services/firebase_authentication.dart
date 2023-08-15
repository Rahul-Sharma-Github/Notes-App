// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class AuthenticationServices {
  // AuthController for state management
  final AuthController authController = Get.put(AuthController());

  // Sign Up Service
  static Future signUp(
      String emailAddress, String password, String name) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      // updating user's Display Name
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser?.reload();

      Get.snackbar('', 'Account created Successfully !');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Warning', 'The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Warning', 'The account already exists for that email.');
        print('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Warning', 'Email is not valid.');
        print('Email is not valid.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Sign In Service
  static Future signIn(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Get.snackbar('', 'Logged In Successfully !');
      // Get.to(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Warning', 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Warning', 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Warning', 'Email is not valid.');
        print('Email is not valid.');
      }
    }
  }

  // Sign Out Service
  static Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then(
            (value) => Get.snackbar('', 'User Signed Out !'),
          );
    } catch (e) {
      print(e);
    }
  }

  // User Account Delete Service
  static Future deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete().then(
            (value) => print('Account Deleted'),
          );
      Get.snackbar('', 'User Account Deleted !');
      // Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Get.snackbar('', 'First, SignIn with a User Account !');
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    } catch (e) {
      print(e);
    }
  }
}
