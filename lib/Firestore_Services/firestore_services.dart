// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
import 'package:intl/intl.dart';
import 'package:note_taking_app/Pages/notes_details/notes_details_controller.dart';

import '../Pages/notes_details/notes_details_page.dart';

class FirestoreServices {
  // Notes Controller initialization
  static NotesDetailsController notesDetailsController =
      Get.put(NotesDetailsController());

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

      Get.snackbar('Note Added !', '');
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
      Get.back();
      Get.snackbar('Note Deleted !', '');
    } catch (e) {
      print(e);
    }
  }

  // Update a specific document from 'notes' collection
  static Future updateData(
      String index, String topic, String description, String datetime) async {
    try {
      await db
          .collection('users')
          .doc(userUID)
          .collection('notes')
          .doc(index)
          .update(
        {"topic": topic, "description": description, "datetime": datetime},
      ).then((value) => print("DocumentSnapshot successfully updated!"),
              onError: (e) => print("Error updating document $e"));
      Get.back();
      Get.snackbar('Note Updated !', '');
    } catch (e) {
      print(e);
    }
  }

  // Read Operations

  // Reading all Notes
  static readNotes() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userUID)
          .collection('notes')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    tileColor: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    title: Text(
                      docSnapshot['topic'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      docSnapshot['datetime'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      // closing the Bottomsheet
                      notesDetailsController.isOpen.value = false;

                      Get.to(
                        transition: Transition.cupertino,
                        () => NotesDetailsPage(
                          index: docSnapshot.id,
                          topic: docSnapshot['topic'],
                          description: docSnapshot['description'],
                          date: docSnapshot['datetime'],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Add Your Notes Now !'),
            );
          }
        }
      },
    );
  }

  // Getting Current Date
  static String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMEd().format(now);
    return formattedDate;
  }
}
