import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/register/pages/signup_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const title = 'Signup Success';
  Widget widgetTest() {
    return const MaterialApp(
      home: SignupSuccessPage(
        text: title,
      ),
    );
  }

  testWidgets('UI Signup Success', (tester) async {
    await tester.pumpWidget(widgetTest());
    await tester.pump();

    expect(find.text(title), findsOneWidget);
    expect(find.text(AppTexts.btnLogin), findsOneWidget);
    expect(find.byType(BaseButton), findsOneWidget);
  });
}
