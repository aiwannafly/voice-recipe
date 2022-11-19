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
    apiKey: 'AIzaSyCYuKUyyDdu-a9VkCgjPPbkFAR4tNEBQ0Y',
    appId: '1:82887997939:web:ed8cb9e158e002bbc7ba86',
    messagingSenderId: '82887997939',
    projectId: 'voice-recipe-10b29',
    authDomain: 'voice-recipe-10b29.firebaseapp.com',
    storageBucket: 'voice-recipe-10b29.appspot.com',
    measurementId: 'G-TD2EZSKK98',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnZPwZ5di0zz6N-jXZFZoy7eNX1lcmPgo',
    appId: '1:82887997939:android:8eee3aa37678572bc7ba86',
    messagingSenderId: '82887997939',
    projectId: 'voice-recipe-10b29',
    storageBucket: 'voice-recipe-10b29.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChjqh94xQN9gSxhk3pnwItJak9xKb1d9s',
    appId: '1:82887997939:ios:49a4329a5b1aeb23c7ba86',
    messagingSenderId: '82887997939',
    projectId: 'voice-recipe-10b29',
    storageBucket: 'voice-recipe-10b29.appspot.com',
    iosClientId: '82887997939-keiar2rf2cvs2oucojj0p6jd0h4ipgus.apps.googleusercontent.com',
    iosBundleId: 'com.example.voiceRecipe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChjqh94xQN9gSxhk3pnwItJak9xKb1d9s',
    appId: '1:82887997939:ios:49a4329a5b1aeb23c7ba86',
    messagingSenderId: '82887997939',
    projectId: 'voice-recipe-10b29',
    storageBucket: 'voice-recipe-10b29.appspot.com',
    iosClientId: '82887997939-keiar2rf2cvs2oucojj0p6jd0h4ipgus.apps.googleusercontent.com',
    iosBundleId: 'com.example.voiceRecipe',
  );
}
