import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: authState.when(
          data: (user) {
            if (user != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Signed in as ${user.uid}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                    child: const Text('Sign out'),
                  ),
                ],
              );
            }
            return ElevatedButton(
              onPressed: () => ref.read(authControllerProvider.notifier).signInWithApple(),
              child: const Text('Sign in with Apple'),
            );
          },
          error: (e, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(authControllerProvider.notifier).signInWithApple(),
                child: const Text('Retry'),
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
