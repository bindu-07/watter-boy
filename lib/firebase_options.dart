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
    apiKey: 'AIzaSyAk3f4HndozujCPzkebiAFx9_8Zjw-ZXoo',
    appId: '1:144270879312:web:a8d4a1ce83cf1997083f55',
    messagingSenderId: '144270879312',
    projectId: 'watterboy-c74c2',
    authDomain: 'watterboy-c74c2.firebaseapp.com',
    storageBucket: 'watterboy-c74c2.firebasestorage.app',
    measurementId: 'G-TBHZE4SX4N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrovIF-epzo0FBnHxE9FLzoZhucTwBaLI',
    appId: '1:144270879312:android:d7301b30c40a0015083f55',
    messagingSenderId: '144270879312',
    projectId: 'watterboy-c74c2',
    storageBucket: 'watterboy-c74c2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjmyF-TsM0zsfHiX74rUl4XcMG0rVxMzM',
    appId: '1:144270879312:ios:f6c5ade8e80eb068083f55',
    messagingSenderId: '144270879312',
    projectId: 'watterboy-c74c2',
    storageBucket: 'watterboy-c74c2.firebasestorage.app',
    androidClientId: '144270879312-45mg525aln99p68ss9860m6pc54rqlih.apps.googleusercontent.com',
    iosClientId: '144270879312-fkd8idcqt1q6emcquabdhtsh5a1dk57c.apps.googleusercontent.com',
    iosBundleId: 'com.example.waterBoy',
  );

}