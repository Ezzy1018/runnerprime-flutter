import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/services/firebase_service.dart';
import 'core/services/crash_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  CrashService.enable();
  runApp(const ProviderScope(child: RunnerPrimeApp()));
}
