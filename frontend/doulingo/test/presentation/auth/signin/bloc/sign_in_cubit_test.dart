import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/auth/entities/user.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:doulingo/presentation/auth/signin/bloc/sign_in_cubit.dart';
import 'package:doulingo/presentation/auth/signin/bloc/sign_in_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockSigninUseCase extends Mock implements SigninUseCase {}

void main() {
  late MockSigninUseCase mockSigninUseCase;
  late SignInCubit signInCubit;
  final locator = GetIt.instance;

  setUp(() {
    mockSigninUseCase = MockSigninUseCase();
    signInCubit = SignInCubit();
    locator.registerLazySingleton<SigninUseCase>(() => mockSigninUseCase);
  });

  tearDown(() {
    locator.reset();
    signInCubit.close();
  });

  group('Signin Cubit', () {
    String email = 'email@example.com';
    String password = 'password';
    final user = UserEntity(
      bio: '',
      courseId: [''],
      email: 'email@example.com',
    );

    test('Emit Initial State', () {
      expect(signInCubit.state, equals(InitialSignInState()));
    });

    blocTest(
      'Emit [Loading, SigninSuccess] State',
      build: () {
        when(() => mockSigninUseCase.call(params: any(named: 'params')))
            .thenAnswer((_) async => Right(user));
        return signInCubit;
      },
      act: (cubit) => cubit.signIn(email, password),
      expect: () => [
        SigninLoadingState(),
        SigninSuccessState(user: user),
      ],
    );

    blocTest(
      'Emit [Loading, SigninFailure] State',
      build: () {
        when(() => mockSigninUseCase.call(params: any(named: 'params')))
            .thenAnswer((_) async => const Left('SignIn Failed'));
        return signInCubit;
      },
      act: (cubit) => cubit.signIn(email, password),
      expect: () => [
        SigninLoadingState(),
        SigninErrorState(errorMessage: 'SignIn Failed'),
      ],
    );
  });
}
