import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_name_page.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_password.dart';
import 'package:doulingo/presentation/auth/register/widgets/text_manual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const email = 'email@gmail.com';

  Widget widgetTest() {
    return const MaterialApp(
      home: EnterNamePage(
        email: email,
      ),
    );
  }

  testWidgets('Enter Name Page', (tester) async {
    await tester.pumpWidget(widgetTest());
    await tester.pump();

    expect(find.byType(AppbarBase), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    expect(find.byKey(const ValueKey('enter_name_body')), findsOneWidget);
    expect(find.byType(TextManual), findsOneWidget);

    expect(find.text(AppTexts.tvNameTitle), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'pi');
    await tester.enterText(find.byType(TextField).at(1), 'long');

    await tester.tap(find.byType(BaseButton));
    await tester.pump();

    expect(find.byType(EnterPasswordPage), findsNothing);
  });
}
