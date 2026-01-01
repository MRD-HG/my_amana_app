import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

class FirebaseBootstrap {
  static bool enabled = false;

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      enabled = true;
    } catch (error) {
      enabled = false;
      debugPrint('Firebase disabled: $error');
    }
  }
}
