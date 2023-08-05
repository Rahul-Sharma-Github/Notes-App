// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  // Getting and initializing an Instance of our Cloud Firestore Database
  static var db = FirebaseFirestore.instance;

  // Getting currently signedIn user's UID
  static var userUID = FirebaseAuth.instance.currentUser!.uid;

  // Add data to Firestore Database
  // the data will be stored in 'users' collection and doc's unique ID will be Current SignedIn user's UID
  // and in the Document(with user's UID) their is a subcollection named 'notes'
  // and notes will be stored inside the 'notes' subcollection with auto generated document UID
  static Future addData(Map<String, dynamic> docData, String uid) async {
    try {
      await db
          .collection('users')
          .doc(userUID)
          .collection('notes')
          .add(docData)
          .then((documentSnapshot) =>
              print("Added Data with ID: ${documentSnapshot.id}"));
    } catch (e) {
      print(e);
    }
  }

  // Delete a specific document from 'notes' collection
  static Future deleteData(String index) async {
    try {
      await db
          .collection('users')
          .doc(userUID)
          .collection('notes')
          .doc(index)
          .delete()
          .then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
    } catch (e) {
      print(e);
    }
  }

  // Update a specific document from 'notes' collection
  static Future updateData(
      String index, String topic, String description) async {
    try {
      await db
          .collection('users')
          .doc(userUID)
          .collection('notes')
          .doc(index)
          .update({"topic": topic, "description": description}).then(
              (value) => print("DocumentSnapshot successfully updated!"),
              onError: (e) => print("Error updating document $e"));
    } catch (e) {
      print(e);
    }
  }
}
