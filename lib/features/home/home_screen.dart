import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('RunnerPrime')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user == null) ...[
              const Text('Welcome'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/auth'),
                child: const Text('Sign in'),
              ),
            ] else ...[
              Text('Hello, ${user.uid.substring(0, 6)}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/run'),
                child: const Text('Start Run'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                child: const Text('Sign out'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
