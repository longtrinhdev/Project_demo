import 'package:dartz/dartz.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_cubit.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_state.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckUserUC extends Mock implements CheckUserUseCase {}

void main() {
  late SignUpCubit cubit;
  final locator = GetIt.instance;
  late MockCheckUserUC checkUserUseCase;

  setUp(() {
    checkUserUseCase = MockCheckUserUC();
    locator.registerLazySingleton<CheckUserUseCase>(() => checkUserUseCase);
    cubit = SignUpCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('Enter Email Page', () {
    Widget widgetTest() {
      return MaterialApp(
        home: BlocProvider<SignUpCubit>.value(
          value: cubit,
          child: const EnterEmailPage(),
        ),
      );
    }

    testWidgets('Ui when state is Initial', (tester) async {
      await tester.pumpWidget(widgetTest());

      expect(find.byType(AppbarBase), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(5));
      expect(find.byType(BaseButton), findsOneWidget);
    });

    testWidgets('UI when state is loading', (tester) async {
      cubit.emit(SignupLoading());
      await tester.pumpWidget(widgetTest());

      expect(find.byType(SpinKitThreeBounce), findsOneWidget);
    });

    testWidgets('UI when User exist ', (tester) async {
      when(
        () => checkUserUseCase.call(
          params: any(named: 'params'),
        ),
      ).thenAnswer((_) async => const Right(true));
      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'example.@gmail.com');
      await tester.tap(find.byType(BaseButton));

      await cubit.userExist('example.@gmail.com');
      cubit.emit(SignupSuccessState(isSuccess: true));

      expect(cubit.state, isA<SignupSuccessState>());
    });

    testWidgets('UI when User not found ', (tester) async {
      when(
        () => checkUserUseCase.call(
          params: any(named: 'params'),
        ),
      ).thenAnswer((_) async => const Right(false));
      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'example.@gmail.com');

      await cubit.userExist('example.@gmail.com');
      cubit.emit(SignupSuccessState(isSuccess: false));

      expect(cubit.state, isA<SignupSuccessState>());
    });

    testWidgets('UI when return error message ', (tester) async {
      when(
        () => checkUserUseCase.call(
          params: any(named: 'params'),
        ),
      ).thenAnswer((_) async => const Left('Email is not valid'));
      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'example.@gmail.com');

      await cubit.userExist('example.@gmail.com');
      cubit.emit(SignupFailureState(errorMessage: 'Email is not valid'));

      expect(cubit.state, isA<SignupFailureState>());
    });
  });
}
