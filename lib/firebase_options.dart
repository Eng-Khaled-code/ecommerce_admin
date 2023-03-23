
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web =FirebaseOptions(
      apiKey: "AIzaSyAgw_nZ4xnVZ5Qs9paBuIwlgq4148OfWHg",
      authDomain: "fireshopsbase.firebaseapp.com",
      databaseURL: "https://fireshopsbase.firebaseio.com",
      projectId: "fireshopsbase",
      storageBucket: "fireshopsbase.appspot.com",
      messagingSenderId: "350979288640",
      appId: "1:350979288640:web:8fbe5f05bd3c2ee07239a5",
      measurementId: "G-2JTXNXLYLE",

  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyD09Cz0-4aUByAnDb3SGP-TIXxFt2xhHg8",
    appId: '1:350979288640:android:59fdc8759fbb59567239a5',
    messagingSenderId: '350979288640',
    projectId: 'fireshopsbase',
    databaseURL: "https://fireshopsbase.firebaseio.com",
    storageBucket: "fireshopsbase.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgsxAsawP1i-OLTZh6JbNMzRac1zlNKvE',
    appId: '1:350979288640:ios:e541e330b43ff1527239a5',
    messagingSenderId: '350979288640',
    projectId: 'fireshopsbase',
    databaseURL: "https://fireshopsbase.firebaseio.com",
    storageBucket: "fireshopsbase.appspot.com",
    iosBundleId: 'com.engoo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgsxAsawP1i-OLTZh6JbNMzRac1zlNKvE',
    appId: '1:350979288640:ios:e541e330b43ff1527239a5',
    messagingSenderId: '350979288640',
    projectId: 'fireshopsbase',
    databaseURL: "https://fireshopsbase.firebaseio.com",
    storageBucket: "fireshopsbase.appspot.com",
    iosBundleId: 'com.engoo',
  );
}