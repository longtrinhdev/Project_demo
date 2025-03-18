import 'package:bloc_test/bloc_test.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_cubit.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_state.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignupCubit extends MockCubit<SignUpState> implements SignUpCubit {}

void main() {
  late MockSignupCubit cubit;
  const email = 'example@gmail.com';
  const name = 'pi';

  setUp(() {
    cubit = MockSignupCubit();
  });

  tearDown(() {
    cubit.close();
  });

  Widget widgetTest() {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => cubit,
        child: const EnterPasswordPage(
          name: name,
          email: email,
        ),
      ),
    );
  }

  group('Enter Password Page', () {
    testWidgets('Ui when state is initial', (tester) async {
      when(() => cubit.state).thenReturn(SignupInitial());

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      expect(find.byType(AppbarBase), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(BaseButton), findsOneWidget);
      expect(find.text(AppTexts.tvPasswordTitle), findsOneWidget);
    });

    testWidgets('Ui when state is loading', (tester) async {
      when(() => cubit.state).thenReturn(SignupLoading());

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), '123456');
      await tester.pump();

      expect(cubit.state, isA<SignupLoading>());
      expect(find.byType(EnterPasswordPage), findsOneWidget);
    });

    testWidgets('Ui when state is loaded', (tester) async {
      when(() => cubit.state).thenReturn(SignupSuccessState(isSuccess: true));

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), '123456');
      await tester.pump();

      expect(cubit.state, isA<SignupSuccessState>());
      expect(find.byType(EnterPasswordPage), findsOneWidget);
    });

    testWidgets('Ui when state is failure', (tester) async {
      when(() => cubit.state)
          .thenReturn(SignupFailureState(errorMessage: 'Failure'));

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      await tester.enterText(find.byType(TextField), '123456');
      await tester.pump();

      expect(cubit.state, isA<SignupFailureState>());
      expect(find.byType(EnterPasswordPage), findsOneWidget);
    });
  });
}
