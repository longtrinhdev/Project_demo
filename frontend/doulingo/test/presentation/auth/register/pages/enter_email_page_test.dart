import 'package:bloc_test/bloc_test.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_cubit.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_state.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_email_page.dart';
import 'package:doulingo/presentation/auth/signin/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignupCubit extends MockCubit<SignUpState> implements SignUpCubit {}

void main() {
  late MockSignupCubit cubit;
  bool mockUserExist = true;

  setUp(() {
    cubit = MockSignupCubit();
  });

  tearDown(() {
    cubit.close();
  });

  Widget widgetTest(Widget body) {
    return MaterialApp(
      home: BlocProvider<SignUpCubit>(
        create: (context) => cubit,
        child: body,
      ),
    );
  }

  group('Enter Email Page', () {
    testWidgets('UI when state is initial', (tester) async {
      when(() => cubit.state).thenReturn(SignupInitial());

      await tester.pumpWidget(
        widgetTest(
          const EnterEmailPage(),
        ),
      );

      expect(find.byType(AppbarBase), findsOneWidget);
      expect(find.text(AppTexts.tvEmailTitle), findsOneWidget);
      expect(find.text(AppTexts.tvEmailHint), findsOneWidget);
      expect(find.byType(BaseButton), findsOneWidget);
      expect(find.byKey(const ValueKey('_back')), findsOneWidget);
    });

    testWidgets('UI when state is loading', (tester) async {
      when(() => cubit.state).thenReturn(SignupLoading());

      await tester.pumpWidget(
        widgetTest(
          const EnterEmailPage(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pump();

      expect(find.byType(AppbarBase), findsOneWidget);
      expect(find.text(AppTexts.tvEmailTitle), findsOneWidget);
      expect(cubit.state, isA<SignupLoading>());
    });

    testWidgets('UI when state is Loaded', (tester) async {
      when(() => cubit.state)
          .thenReturn(SignupSuccessState(isSuccess: mockUserExist));

      await tester.pumpWidget(
        widgetTest(
          const EnterEmailPage(),
        ),
      );
      await tester.pump();

      expect(cubit.state, isA<SignupSuccessState>());
      expect(find.byType(SigninPage), findsNothing);
    });

    testWidgets('UI when state is failure', (tester) async {
      when(() => cubit.state)
          .thenReturn(SignupFailureState(errorMessage: 'Error message'));

      await tester.pumpWidget(
        widgetTest(
          const EnterEmailPage(),
        ),
      );
      await tester.pump();

      expect(cubit.state, isA<SignupFailureState>());
      expect(find.byType(SigninPage), findsNothing);
    });
  });
}
