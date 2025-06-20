// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyB_ydWABPRB60ySJI7tqlZtbG4Tiw-s18Q',
    appId: '1:673399327701:web:f1e743ab4f1cb49dcd4b5c',
    messagingSenderId: '673399327701',
    projectId: 'flutter-pos-app-17898',
    authDomain: 'flutter-pos-app-17898.firebaseapp.com',
    storageBucket: 'flutter-pos-app-17898.firebasestorage.app',
    measurementId: 'G-PNC6NR7NMZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAj8mkKqLTj3Uhrr3xoGzVCX1EiigSAjUY',
    appId: '1:673399327701:android:4e93e4da731fe106cd4b5c',
    messagingSenderId: '673399327701',
    projectId: 'flutter-pos-app-17898',
    storageBucket: 'flutter-pos-app-17898.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGeeLD4z2tSOdZQ859qwrnXph7whoab_c',
    appId: '1:673399327701:ios:f6f3ac3927f253f0cd4b5c',
    messagingSenderId: '673399327701',
    projectId: 'flutter-pos-app-17898',
    storageBucket: 'flutter-pos-app-17898.firebasestorage.app',
    iosBundleId: 'com.example.posApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGeeLD4z2tSOdZQ859qwrnXph7whoab_c',
    appId: '1:673399327701:ios:f6f3ac3927f253f0cd4b5c',
    messagingSenderId: '673399327701',
    projectId: 'flutter-pos-app-17898',
    storageBucket: 'flutter-pos-app-17898.firebasestorage.app',
    iosBundleId: 'com.example.posApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB_ydWABPRB60ySJI7tqlZtbG4Tiw-s18Q',
    appId: '1:673399327701:web:65cbb60c77aedb7acd4b5c',
    messagingSenderId: '673399327701',
    projectId: 'flutter-pos-app-17898',
    authDomain: 'flutter-pos-app-17898.firebaseapp.com',
    storageBucket: 'flutter-pos-app-17898.firebasestorage.app',
    measurementId: 'G-B1RXTK1KJ5',
  );
}
