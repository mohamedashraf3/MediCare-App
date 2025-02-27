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
    apiKey: 'AIzaSyBeNULavpBPSFVN-yd1SF0iDJzyJC940nw',
    appId: '1:82283338045:web:5426e2ded34979d2b0cd54',
    messagingSenderId: '82283338045',
    projectId: 'medicare-app-a1dbd',
    authDomain: 'medicare-app-a1dbd.firebaseapp.com',
    databaseURL: 'https://medicare-app-a1dbd-default-rtdb.firebaseio.com',
    storageBucket: 'medicare-app-a1dbd.appspot.com',
    measurementId: 'G-DB62PHB5GS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBK2fiwe44Ab9dynHRQlem6CqQXWN0uBzM',
    appId: '1:82283338045:android:e1ecabc1e6a9d88ab0cd54',
    messagingSenderId: '82283338045',
    projectId: 'medicare-app-a1dbd',
    databaseURL: 'https://medicare-app-a1dbd-default-rtdb.firebaseio.com',
    storageBucket: 'medicare-app-a1dbd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9FA9-wjq6S6AV0nH48EKz_b_G42DJH-4',
    appId: '1:82283338045:ios:49b41f517bdfca23b0cd54',
    messagingSenderId: '82283338045',
    projectId: 'medicare-app-a1dbd',
    databaseURL: 'https://medicare-app-a1dbd-default-rtdb.firebaseio.com',
    storageBucket: 'medicare-app-a1dbd.appspot.com',
    androidClientId: '82283338045-uotgue295blr537fikcg7deeh6lhjc7s.apps.googleusercontent.com',
    iosClientId: '82283338045-m989asaeke033qumi9f4it2o802hv46u.apps.googleusercontent.com',
    iosBundleId: 'medicare.com.medicare',
  );

}