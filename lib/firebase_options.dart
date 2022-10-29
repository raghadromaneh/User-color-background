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
    apiKey: 'AIzaSyBT4NVK4AgojOTsJ7YsF4dcaTjLKuF5Fy0',
    appId: '1:612480397155:web:dab670ab93fde9b0e4ed56',
    messagingSenderId: '612480397155',
    projectId: 'user-color-background',
    authDomain: 'user-color-background.firebaseapp.com',
    storageBucket: 'user-color-background.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkDXSpEFEa0kP9f_wuZ0hq4ysNcHRw5IU',
    appId: '1:612480397155:android:ae76b2b780c5a65ee4ed56',
    messagingSenderId: '612480397155',
    projectId: 'user-color-background',
    storageBucket: 'user-color-background.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCa88iGyTlTS7lOdQDbj4kq8DxdEmZDTao',
    appId: '1:612480397155:ios:d594f5e44195e2bfe4ed56',
    messagingSenderId: '612480397155',
    projectId: 'user-color-background',
    storageBucket: 'user-color-background.appspot.com',
    iosClientId: '612480397155-fg33jtcdo0bcpjoejgm0icbma6nbarge.apps.googleusercontent.com',
    iosBundleId: 'com.example.usercolorbackground',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCa88iGyTlTS7lOdQDbj4kq8DxdEmZDTao',
    appId: '1:612480397155:ios:d594f5e44195e2bfe4ed56',
    messagingSenderId: '612480397155',
    projectId: 'user-color-background',
    storageBucket: 'user-color-background.appspot.com',
    iosClientId: '612480397155-fg33jtcdo0bcpjoejgm0icbma6nbarge.apps.googleusercontent.com',
    iosBundleId: 'com.example.usercolorbackground',
  );
}
