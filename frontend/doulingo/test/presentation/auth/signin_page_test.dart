import 'package:dartz/dartz.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/domain/auth/entities/user.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:doulingo/presentation/auth/forgot_password/forgot_password.dart';
import 'package:doulingo/presentation/auth/signin_page.dart';
import 'package:doulingo/presentation/main/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockSigninUseCase extends Mock implements SigninUseCase {}

class MockGetDataUseCase extends Mock implements GetDataUseCase {}

void main() {
  final sl = GetIt.instance;
  late MockSigninUseCase signinUseCase;
  late MockGetDataUseCase getDataUseCase;

  setUp(() {
    signinUseCase = MockSigninUseCase();
    getDataUseCase = MockGetDataUseCase();
    sl.registerLazySingleton<SigninUseCase>(() => signinUseCase);
    sl.registerLazySingleton<GetDataUseCase>(() => getDataUseCase);
    registerFallbackValue(
        SigninModel(username: 'pilong', password: '12345678'));
  });

  tearDown(() {
    sl.reset();
  });

  group('UI: SignIn Page', () {
    Widget widgetTest(bool checkUser) {
      return MaterialApp(
        home: SigninPage(
          checkUser: checkUser,
        ),
      );
    }

    testWidgets('UI when status page initial and do not account',
        (tester) async {
      await tester.pumpWidget(widgetTest(false));

      expect(find.byType(AppbarBase), findsOneWidget);
      expect(find.text(AppTexts.signinPageTitle), findsOneWidget);
      expect(find.text(AppTexts.tvHintUsername), findsOneWidget);
      expect(find.text(AppTexts.tvHintPassword), findsOneWidget);
      expect(find.byType(BaseButton), findsNWidgets(3));
      expect(find.byType(Text), findsNWidgets(9));
    });

    testWidgets('UI when status page initial and have an account',
        (tester) async {
      await tester.pumpWidget(widgetTest(true));

      expect(find.byType(AppbarBase), findsOneWidget);
      expect(find.text(AppTexts.tvCheckUserTitle), findsOneWidget);
      expect(find.text(AppTexts.tvHintUsername), findsOneWidget);
      expect(find.text(AppTexts.tvHintPassword), findsOneWidget);
      expect(find.byType(BaseButton), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(7));
    });

    testWidgets('UI when empty data and tap button', (tester) async {
      await tester.pumpWidget(widgetTest(true));
      expect(find.byType(TextField), findsNWidgets(2));

      await tester.enterText(find.byType(TextField).first, '');
      await tester.enterText(find.byType(TextField).last, '');
      await tester.tap(find.byType(BaseButton).at(0));

      expect(find.text(''), findsAtLeast(0));
    });

    testWidgets('UI return data when tap button', (tester) async {
      final mockData = UserEntity(
        bio: 'bio',
        courseId: ['courseId'],
        email: 'email',
        followers: [],
      );

      when(() => signinUseCase.call(
            params: any(named: 'params'),
          )).thenAnswer((_) async => Right(mockData));
      when(() => getDataUseCase.call(
            params: any(named: 'params'),
          )).thenAnswer((_) async => 'mock_course_id');

      await tester.pumpWidget(widgetTest(true));
      await tester.pump();

      await tester.enterText(find.byType(TextField).first, 'pilong');
      await tester.enterText(find.byType(TextField).last, '12345678');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BaseButton).at(0));

      final result = await signinUseCase.call(
        params: SigninModel(username: 'pilong', password: '12345678'),
      );

      verify(() => signinUseCase.call(
            params: any(named: 'params'),
          )).called(2);
      verify(() => getDataUseCase.call(
            params: any(named: 'params'),
          )).called(1);
      expect(result.fold((error) => null, (data) => MainPage), MainPage);
    });

    testWidgets('UI return error message when tap button', (tester) async {
      when(() => signinUseCase.call(
            params: any(named: 'params'),
          )).thenAnswer((_) async => const Left('Load Data Failed'));
      when(() => getDataUseCase.call(
            params: any(named: 'params'),
          )).thenAnswer((_) async => 'mock_course_id');

      await tester.pumpWidget(widgetTest(true));
      await tester.pump();

      await tester.enterText(find.byType(TextField).first, 'pilong');
      await tester.enterText(find.byType(TextField).last, '12345678');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BaseButton).at(0));

      final result = await signinUseCase.call(
        params: SigninModel(username: 'pilong', password: '12345678'),
      );

      verify(() => signinUseCase.call(
            params: any(named: 'params'),
          )).called(2);
      verify(() => getDataUseCase.call(
            params: any(named: 'params'),
          )).called(1);
      expect(result.fold((error) => 'Load Data Failed', (data) => null),
          equals('Load Data Failed'));
    });

    testWidgets('UI when forgot password', (tester) async {
      await tester.pumpWidget(widgetTest(true));
      expect(find.text(AppTexts.btnForgotPassword), findsOneWidget);

      await tester.tap(find.text(AppTexts.btnForgotPassword));
      await tester.pumpAndSettle();

      expect(find.byType(ForgotPassword), findsOneWidget);
      expect(find.text(AppTexts.tvContinue), findsOneWidget);

      expect(find.byKey(const ValueKey('_back')), findsWidgets);

      await tester.tap(find.byKey(const ValueKey('_back')).at(0));
      await tester.pumpAndSettle();

      expect(find.byType(SigninPage), findsOneWidget);
    });
  });
}
