import 'package:dartz/dartz.dart';
import 'package:doulingo/common/bloc/generate_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/use_case/forgot_pw.dart';
import 'package:doulingo/presentation/auth/forgot_password/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockForgotPWUseCase extends Mock implements ForgotPwUseCase {}

void main() {
  late MockForgotPWUseCase mockForgotPWUseCase;
  late GenerateCubit cubit;
  final locator = GetIt.instance;
  final signupModel = SignupModel(
    email: 'email@example.com',
  );

  setUp(() {
    mockForgotPWUseCase = MockForgotPWUseCase();
    cubit = GenerateCubit();
    locator.registerLazySingleton<ForgotPwUseCase>(() => mockForgotPWUseCase);
    registerFallbackValue(SignupModel(
      email: 'email@example.com',
    ));
  });

  tearDown(() {
    locator.reset();
    cubit.close();
  });

  group('Forgot Password', () {
    Widget widgetTest() {
      return MaterialApp(
        home: BlocProvider<GenerateCubit>.value(
          value: cubit,
          child: const ForgotPassword(),
        ),
      );
    }

    testWidgets('UI when state is Initial', (tester) async {
      cubit.emit(InitialState());
      await tester.pumpWidget(widgetTest());

      expect(find.byType(AppbarBase), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(BaseButton), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(5));
    });

    testWidgets('UI when state is Loading ', (tester) async {
      when(
        () => mockForgotPWUseCase.call(params: any(named: 'params')),
      ).thenAnswer((_) async => const Right('Reset Password Success'));

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'email@example.com');
      await tester.tap(find.byType(BaseButton));

      await cubit.getData<String>(mockForgotPWUseCase, params: signupModel);
      cubit.emit(DataLoading());
      await tester.pumpAndSettle();

      expect(cubit.state, isA<DataLoading>());
      verify(() => mockForgotPWUseCase.call(params: any(named: 'params')))
          .called(1);
    });

    testWidgets('UI when state is Loaded ', (tester) async {
      when(
        () => mockForgotPWUseCase.call(params: any(named: 'params')),
      ).thenAnswer((_) async => const Right('Reset Password Success'));

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'email@example.com');
      await tester.tap(find.byType(BaseButton));

      await cubit.getData<String>(mockForgotPWUseCase, params: signupModel);
      cubit.emit(DataLoaded(data: 'Reset Password Success'));

      expect(cubit.state, isA<DataLoaded>());
      verify(() => mockForgotPWUseCase.call(params: any(named: 'params')))
          .called(1);
    });

    testWidgets('UI when state is LoadFailure ', (tester) async {
      when(
        () => mockForgotPWUseCase.call(params: any(named: 'params')),
      ).thenAnswer((_) async => const Left('Reset Password Failed'));

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'email@example.com');
      await tester.tap(find.byType(BaseButton));

      await cubit.getData<String>(mockForgotPWUseCase, params: signupModel);
      cubit.emit(DataLoadedFailure(errorMessage: 'Reset Password Failed'));

      expect(cubit.state, isA<DataLoadedFailure>());
      verify(() => mockForgotPWUseCase.call(params: any(named: 'params')))
          .called(1);
    });
  });
}
