import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

class FirebaseService {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Touch singletons to ensure lazy init
    // ignore: unused_local_variable
    final auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    final firestore = FirebaseFirestore.instance;
    // ignore: unused_local_variable
    final analytics = FirebaseAnalytics.instance;
    _initialized = true;
  }
}
