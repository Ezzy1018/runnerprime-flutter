import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:runnerprime_flutter/features/home/home_screen.dart';

void main() {
  testWidgets('Home shows Sign in button when unauthenticated', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: HomeScreen())));
    expect(find.text('Sign in'), findsOneWidget);
  });
}
