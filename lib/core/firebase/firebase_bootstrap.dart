import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

enum AppMode { firebase, demo }

class FirebaseBootstrap {
  static AppMode mode = AppMode.demo;

  static bool get enabled => mode == AppMode.firebase;

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      mode = AppMode.firebase;
      debugPrint('App mode: Firebase');
    } catch (error) {
      mode = AppMode.demo;
      debugPrint('App mode: Demo ($error)');
    }
  }
}
