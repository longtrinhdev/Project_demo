import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/signin/pages/signin_page.dart';
import 'package:doulingo/presentation/collect_info/pages/welcome.dart';
import 'package:doulingo/presentation/introduce/introduce_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  testWidgets('UI Introduce Page', (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: IntroducePage(),
        ),
      );
      await tester.pump();

      expect(find.byKey(const ValueKey('intro_page_image')), findsOneWidget);
      expect(find.byType(BaseButton), findsNWidgets(2));
      expect(find.text(AppTexts.btnGetStarted), findsOneWidget);

      await tester.tap(find.byType(BaseButton).at(0));
      await tester.pumpAndSettle();

      expect(find.byType(WelcomePage), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('_back')));
      await tester.pumpAndSettle();

      expect(find.byType(IntroducePage), findsOneWidget);

      await tester.tap(find.byType(BaseButton).at(1));
      await tester.pumpAndSettle();

      expect(find.byType(SigninPage), findsOneWidget);
    });
  });
}
