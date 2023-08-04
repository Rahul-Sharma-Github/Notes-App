// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class Authentication {
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
      Get.snackbar('', 'Account created Successfully !');

      // after sign in we are getting user's information
      var userInformation = credential.user;
      // Storing User Profile Information into variables
      saveUserInformation(userInformation!);
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
  static Future deleteUserAccount(AuthController authController) async {
    try {
      if (authController.isLogin.value == true) {
        await FirebaseAuth.instance.currentUser!.delete().then(
              (value) => Get.snackbar('', 'User Account Deleted !'),
            );
      } else {
        Get.snackbar('', 'First, SignIn with a User Account !');
      }
    } catch (e) {
      print(e);
    }
  }

  // Signed In User's Information
  // storing signed in user's information into variables
  static Future saveUserInformation(User user) async {
    try {
      var userUID = user.uid;
      var userName = user.displayName;
      var userEmail = user.email;
      var userPhoneNumber = user.phoneNumber;
      var userProfilePhoto = user.photoURL;
      var userAccountCreationTime = user.metadata.creationTime;
      var userLastSignInTime = user.metadata.lastSignInTime;
    } catch (e) {
      print(e);
    }
  }

  // Updatinng Signed In User's Information
  static Future updateUserInformation(
      User user, String name, String photoUrl) async {
    try {
      await user.updateDisplayName(name);
      await user.updatePhotoURL(photoUrl);
    } catch (e) {
      print(e);
    }
  }
}
