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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAxWYQaqfuvgQw81Id4wKI7n-vW4m_xScQ',
    appId: '1:363409264063:web:6807ab4e6b3f6e7a42250a',
    messagingSenderId: '363409264063',
    projectId: 'farmind-59c4d',
    authDomain: 'farmind-59c4d.firebaseapp.com',
    storageBucket: 'farmind-59c4d.appspot.com',
    measurementId: 'G-B2DBB1CJG1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBTDYSb0zryZzAWCiCCKeHva6DUg-BAsw',
    appId: '1:363409264063:android:a91183307a29f61242250a',
    messagingSenderId: '363409264063',
    projectId: 'farmind-59c4d',
    storageBucket: 'farmind-59c4d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBP3oRr2AOw1NsLAjj4ohV7RePpkaj_TiE',
    appId: '1:363409264063:ios:ddff2cc7680aeef642250a',
    messagingSenderId: '363409264063',
    projectId: 'farmind-59c4d',
    storageBucket: 'farmind-59c4d.appspot.com',
    iosBundleId: 'com.example.farmind',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAxWYQaqfuvgQw81Id4wKI7n-vW4m_xScQ',
    appId: '1:363409264063:web:c606a56d9de07abe42250a',
    messagingSenderId: '363409264063',
    projectId: 'farmind-59c4d',
    authDomain: 'farmind-59c4d.firebaseapp.com',
    storageBucket: 'farmind-59c4d.appspot.com',
    measurementId: 'G-E6675BTN85',
  );
}