import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final authStateStreamProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges();
});

class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController(this._ref) : super(const AsyncValue.loading()) {
    _subscription = _ref.read(authServiceProvider).authStateChanges().listen(
      (user) => state = AsyncValue.data(user),
      onError: (e, st) => state = AsyncValue.error(e, st),
    );
  }

  final Ref _ref;
  late final Stream<User?> _subscription;

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    try {
      final result = await _ref.read(authServiceProvider).signInWithApple();
      state = AsyncValue.data(result?.user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    await _ref.read(authServiceProvider).signOut();
  }

  @override
  void dispose() {
    // ignore: unused_local_variable
    final _ = _subscription;
    super.dispose();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<User?>>(
  (ref) => AuthController(ref),
);
