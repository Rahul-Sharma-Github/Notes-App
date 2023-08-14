// Notes App

import 'package:flutter/material.dart';

// Getx package
import 'package:get/get.dart';

// Firebase Core + firebase_options
import 'package:firebase_core/firebase_core.dart';
import 'package:note_taking_app/Pages/login/login_page.dart';
import 'package:note_taking_app/firebase_options.dart';

// Firebase Authentication
import 'package:firebase_auth/firebase_auth.dart';

// Project Pages import
import 'package:note_taking_app/Pages/home/home_page.dart';

// Auth_controller
import 'Authentication_Services/auth_controller.dart';

// Device Preview
import 'package:device_preview/device_preview.dart';

// Colors
import 'constants/colors.dart';

// it will initialize our Flutter Firebase app before starting the App

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //AuthenticationController
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // using GetMaterialApp for GetX functionality
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellowBase),
        // Button Theme
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColors.yellowBase),
          ),
        ),
        // FloatingActionButton Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.floatingActionButton),
        // brightness: Brightness.dark,
        useMaterial3: true,
      ),
      // using StreamBuilder for Firebase Authentication purpose (login/signup & HomePage Switching)
      // [ using FirebaseAuth Pre-Built authStateChanges() Method inside StreamBuilder ]
      // It will fire event everytime whenever user login or logout
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // setting isLogin variable to true
            authController.isLogin.value = true;
            // if user logged in then Go to HomePage
            return const HomePage();
          } else {
            // setting isLogin variable to false
            authController.isLogin.value = false;
            // after logout user will go to LogInPage
            return const LogInPage();
          }
        },
      ),
    );
  }
}
