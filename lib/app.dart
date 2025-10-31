import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/design/design_tokens.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/home_screen.dart';
import 'features/run/run_screen.dart';

class RunnerPrimeApp extends StatelessWidget {
  const RunnerPrimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/auth', builder: (_, __) => const AuthScreen()),
        GoRoute(path: '/run', builder: (_, __) => const RunScreen()),
      ],
    );

    final theme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(AppColors.eerieBlack),
      colorScheme: const ColorScheme.dark(
        primary: Color(AppColors.lime),
        secondary: Color(AppColors.lime),
        surface: Color(AppColors.eerieBlack),
        onPrimary: Colors.black,
        onSurface: Color(AppColors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(AppColors.eerieBlack),
        foregroundColor: Color(AppColors.white),
        elevation: 0,
      ),
      useMaterial3: true,
    );

    return MaterialApp.router(
      title: 'RunnerPrime',
      theme: theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
