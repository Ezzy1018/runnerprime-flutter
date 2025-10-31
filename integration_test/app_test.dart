import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:runnerprime_flutter/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App boots and shows Home', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RunnerPrimeApp()));
    await tester.pumpAndSettle();

    expect(find.text('RunnerPrime'), findsOneWidget);
  });
}
