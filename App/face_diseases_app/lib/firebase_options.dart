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
    apiKey: 'AIzaSyCp4GfztZhq-YlkAoMzI58DBxaUCOSnDXE',
    appId: '1:1072306408314:web:e86c74d29f332cdaaae4c3',
    messagingSenderId: '1072306408314',
    projectId: 'facediseasesapp-635d0',
    authDomain: 'facediseasesapp-635d0.firebaseapp.com',
    storageBucket: 'facediseasesapp-635d0.appspot.com',
    measurementId: 'G-L71JLF79N6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAohS9uoxVUzyYUw4Z-8JqGM1H99RAEscE',
    appId: '1:1072306408314:android:a86e528b0a7f04c8aae4c3',
    messagingSenderId: '1072306408314',
    projectId: 'facediseasesapp-635d0',
    storageBucket: 'facediseasesapp-635d0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3JE0J2AT6am2NmlZ5i43_8JfTZLjoXRE',
    appId: '1:1072306408314:ios:81e2a03fd637b2b0aae4c3',
    messagingSenderId: '1072306408314',
    projectId: 'facediseasesapp-635d0',
    storageBucket: 'facediseasesapp-635d0.appspot.com',
    iosBundleId: 'com.example.faceDiseasesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3JE0J2AT6am2NmlZ5i43_8JfTZLjoXRE',
    appId: '1:1072306408314:ios:e660a19151547bc3aae4c3',
    messagingSenderId: '1072306408314',
    projectId: 'facediseasesapp-635d0',
    storageBucket: 'facediseasesapp-635d0.appspot.com',
    iosBundleId: 'com.example.faceDiseasesApp.RunnerTests',
  );
}
