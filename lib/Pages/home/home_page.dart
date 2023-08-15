// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Authentication_Services/firebase_authentication.dart';
import '../../Firestore_Services/firestore_services.dart';
import '../../constants/colors.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // homeController
  static HomeController homeController = Get.put(HomeController());

  // Controllers for TextFields
  static TextEditingController topicController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      drawer: Drawer(
        child: ListView(children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(color: AppColors.floatingActionButton),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(FirebaseAuth.instance.currentUser?.displayName ?? ''),
                Text(FirebaseAuth.instance.currentUser?.email ?? ''),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(15),
            title: const Text('Sign Out'),
            trailing: const Icon(Icons.logout),
            onTap: () {
              AuthenticationServices.signOut();
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(15),
            title: const Text('Delete Account'),
            trailing: const Icon(Icons.person_off_outlined),
            onTap: () {
              try {
                AuthenticationServices.deleteUserAccount();
              } catch (e) {
                print('Error while Deleting User Account = $e');
              }
            },
          ),
        ]),
      ),
      body: SafeArea(
        child: Container(
          // Fetching all the Notes from Database
          child: FirestoreServices.readNotes(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            // Changing Icon according to state[Open/Close] of BottomSheet
            Obx(
          () => Icon(
              homeController.isOpen.value ? Icons.horizontal_rule : Icons.add),
        ),
        onPressed: () {
          // Logic to Open or Close the BottomSheet
          if (homeController.isOpen.value) {
            homeController.isOpen.value = false;
          } else {
            homeController.isOpen.value = true;
          }
        },
      ),
      bottomSheet: Obx(
        () => Container(
          child: homeController.isOpen.value
              ? BottomSheet(
                  enableDrag: false,
                  onClosing: () {},
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              autofocus: true,
                              controller: topicController,
                              decoration: const InputDecoration(
                                labelText: 'Enter Note\'s Topic here',
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              minLines: 1,
                              maxLines: 20,
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                labelText: 'Enter Note\'s Description here',
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                try {
                                  // Checking TextFields
                                  if (topicController.text.isEmpty ||
                                      descriptionController.text.isEmpty) {
                                    Get.snackbar('Warning ',
                                        'Please Enter Something to add this Note !');
                                  } else {
                                    // Getting Topic and Description from TextFields
                                    // And Getting Date from Method
                                    var topic = topicController.text;
                                    var description =
                                        descriptionController.text;
                                    var dateTime =
                                        FirestoreServices.getCurrentDateTime();

                                    // Creating Map from these variables
                                    var mapData = {
                                      "topic": topic,
                                      "description": description,
                                      "datetime": dateTime,
                                    };

                                    // Adding this map to Database with user's UID

                                    FirestoreServices.addData(
                                      mapData,
                                      FirestoreServices.userUID,
                                    );

                                    // Resetting TextField
                                    topicController.text = '';
                                    descriptionController.text = '';
                                  }
                                } catch (e) {
                                  print('Error while Adding Data = $e');
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'Add this Note',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
