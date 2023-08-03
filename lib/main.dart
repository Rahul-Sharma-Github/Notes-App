// Notes App

import 'package:flutter/material.dart';

// Getx package
import 'package:get/get.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:note_taking_app/firebase_options.dart';

// it will initialize our Flutter Firebase app before starting the App

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      // use StreamBuilder for Firebase Authentication purpose (login/sign up Page Switching)
      // [ use Firebase Pre-Built userChanges() Method inside StreamBuilder ]
      home: const Placeholder(),
    );
  }
}
