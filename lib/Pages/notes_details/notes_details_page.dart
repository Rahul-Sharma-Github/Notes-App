import 'package:flutter/material.dart';

class NotesDetailsPage extends StatelessWidget {
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

  // Showing specific Document Data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.edit,
          ),
          Icon(
            Icons.delete_forever,
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
    );
  }
}
