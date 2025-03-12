import 'package:doulingo/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:doulingo/main.dart';

void main() {
  Widget testWidget() {
    return const MaterialApp(
      home: MyApp(),
    );
  }

  testWidgets('Unit Test Ui Main', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget());
    // expected
    expect(find.byType(SplashPage), findsOneWidget);
  });
}
