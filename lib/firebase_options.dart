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
    apiKey: 'AIzaSyAMWl5OtSmMDEBScvZiIVOsp9c0MWpfNso',
    appId: '1:1097336796107:web:427f574809e00013ddbc4e',
    messagingSenderId: '1097336796107',
    projectId: 'ayymonu77',
    authDomain: 'ayymonu77.firebaseapp.com',
    storageBucket: 'ayymonu77.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8cBFICNkpIZTgcBkNOKwpqNqOI64-bWw',
    appId: '1:1097336796107:android:58359806160cd26fddbc4e',
    messagingSenderId: '1097336796107',
    projectId: 'ayymonu77',
    storageBucket: 'ayymonu77.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGZJkQngglpIpy_wUl7Xrdu3fZt83kbk8',
    appId: '1:669959449107:ios:bbf28f5599db61826d6de6',
    messagingSenderId: '669959449107',
    projectId: 'projet1dyn',
    storageBucket: 'projet1dyn.firebasestorage.app',
    iosBundleId: 'com.example.imcSecured',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGZJkQngglpIpy_wUl7Xrdu3fZt83kbk8',
    appId: '1:669959449107:ios:bbf28f5599db61826d6de6',
    messagingSenderId: '669959449107',
    projectId: 'projet1dyn',
    storageBucket: 'projet1dyn.firebasestorage.app',
    iosBundleId: 'com.example.imcSecured',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMWl5OtSmMDEBScvZiIVOsp9c0MWpfNso',
    appId: '1:1097336796107:web:18ef8d6217468495ddbc4e',
    messagingSenderId: '1097336796107',
    projectId: 'ayymonu77',
    authDomain: 'ayymonu77.firebaseapp.com',
    storageBucket: 'ayymonu77.firebasestorage.app',
  );

}