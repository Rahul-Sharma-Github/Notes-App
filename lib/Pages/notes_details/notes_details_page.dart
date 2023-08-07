// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Firestore_Services/firestore_services.dart';
import 'notes_details_controller.dart';

class NotesDetailsPage extends StatelessWidget {
  // Variables to get the specific document data from Home page
  final String index;
  final String topic;
  final String description;
  final String date;
  const NotesDetailsPage(
      {super.key,
      required this.index,
      required this.topic,
      required this.description,
      required this.date});

  // controller
  static NotesDetailsController notesDetailsController =
      Get.put(NotesDetailsController());

  // Controllers for TextFormField

  static TextEditingController topicController = TextEditingController();

  static TextEditingController descriptionController = TextEditingController();

  // Showing specific Document Data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: const Icon(
              Icons.edit,
            ),
            onTap: () {
              notesDetailsController.isOpen.value = true;
            },
          ),
          InkWell(
            child: const Icon(
              Icons.delete_forever,
            ),
            onTap: () {
              FirestoreServices.deleteData(index);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(topic),
            Text(description),
            Text(date),
          ],
        ),
      ),
      // Bottom Sheet for Updating the Note
      bottomSheet: Obx(
        () => Container(
          child: notesDetailsController.isOpen.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: topicController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Enter Topic',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        minLines: 1,
                        maxLines: 50,
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Enter Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // getting field data and storing into variables
                          var topic = topicController.text;
                          var description = topicController.text;

                          // updating the note
                          FirestoreServices.updateData(
                              index, topic, description);

                          // closing the Bottomsheet
                          notesDetailsController.isOpen.value = false;

                          Get.snackbar('Note Updated !', '');
                        },
                        child: const Text('Update'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // closing the Bottomsheet
                          notesDetailsController.isOpen.value = false;
                        },
                        child: const Text('Close'),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
