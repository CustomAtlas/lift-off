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
    apiKey: 'AIzaSyBCP1AHOlM46WjldM-B3AtwW2T104zfTAs',
    appId: '1:642226040527:web:b43a118ab7bc7d9d3fd1ba',
    messagingSenderId: '642226040527',
    projectId: 'lift-off-ff399',
    authDomain: 'lift-off-ff399.firebaseapp.com',
    storageBucket: 'lift-off-ff399.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJHZXh2YGnz9qWTkXZT8sEpen1bXpRmnU',
    appId: '1:642226040527:android:f62238fd8f7261093fd1ba',
    messagingSenderId: '642226040527',
    projectId: 'lift-off-ff399',
    storageBucket: 'lift-off-ff399.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOepWV_EECqT8UM0breGKalynrePdCpgY',
    appId: '1:642226040527:ios:1e54b6099b3b757f3fd1ba',
    messagingSenderId: '642226040527',
    projectId: 'lift-off-ff399',
    storageBucket: 'lift-off-ff399.appspot.com',
    iosBundleId: 'com.example.liftOff',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOepWV_EECqT8UM0breGKalynrePdCpgY',
    appId: '1:642226040527:ios:79d7dc2a107ff23e3fd1ba',
    messagingSenderId: '642226040527',
    projectId: 'lift-off-ff399',
    storageBucket: 'lift-off-ff399.appspot.com',
    iosBundleId: 'com.example.liftOff.RunnerTests',
  );
}
