// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCRdqo9vv0QyYGyU8RuAhGs7eoke58t7to',
    appId: '1:832473460285:web:b87a20ae267811f5aa4454',
    messagingSenderId: '832473460285',
    projectId: 'notes-app-b1ff9',
    authDomain: 'notes-app-b1ff9.firebaseapp.com',
    storageBucket: 'notes-app-b1ff9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPLexIfomGCFm0yITqBQ2hGCATPOhVK2s',
    appId: '1:832473460285:android:359f75d1625667d3aa4454',
    messagingSenderId: '832473460285',
    projectId: 'notes-app-b1ff9',
    storageBucket: 'notes-app-b1ff9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMNRKnmBtFWbdqkwCys9MuJgrEl1XhnfA',
    appId: '1:832473460285:ios:d9d63ce58d24fb8daa4454',
    messagingSenderId: '832473460285',
    projectId: 'notes-app-b1ff9',
    storageBucket: 'notes-app-b1ff9.appspot.com',
    iosClientId: '832473460285-g08d2i5r4osa545t1mbu9bgfdo44q4g1.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteTakingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMNRKnmBtFWbdqkwCys9MuJgrEl1XhnfA',
    appId: '1:832473460285:ios:bc6f0af02950d90faa4454',
    messagingSenderId: '832473460285',
    projectId: 'notes-app-b1ff9',
    storageBucket: 'notes-app-b1ff9.appspot.com',
    iosClientId: '832473460285-nh05kdvs71i93f4hv7m6qtdr14lgqta1.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteTakingApp.RunnerTests',
  );
}
