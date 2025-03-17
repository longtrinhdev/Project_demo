import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:doulingo/domain/auth/use_case/signup_use_case.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_cubit.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckUserCase extends Mock implements CheckUserUseCase {}

class MockSignupUseCase extends Mock implements SignupUseCase {}

void main() {
  late MockCheckUserCase mockCheckUserCase;
  late MockSignupUseCase mockSignupUseCase;
  final locator = GetIt.instance;
  late SignUpCubit signUpCubit;

  setUp(() {
    mockCheckUserCase = MockCheckUserCase();
    mockSignupUseCase = MockSignupUseCase();
    locator.registerLazySingleton<CheckUserUseCase>(() => mockCheckUserCase);
    locator.registerLazySingleton<SignupUseCase>(() => mockSignupUseCase);
    signUpCubit = SignUpCubit();
  });

  tearDown(() {
    locator.reset();
    signUpCubit.close();
  });

  test('Emit initial State', () async {
    expect(signUpCubit.state, isA<SignupInitial>());
  });

  group('User Exist', () {
    const email = 'email@example.com';
    blocTest(
      'Emit[Loading, Loaded] State',
      build: () {
        when(
          () => mockCheckUserCase.call(params: any(named: 'params')),
        ).thenAnswer((_) async => const Right(true));
        return signUpCubit;
      },
      act: (cubit) => signUpCubit.userExist(email),
      expect: () => [SignupLoading(), SignupSuccessState(isSuccess: true)],
    );

    blocTest(
      'Emit[Loading, Failure] State',
      build: () {
        when(
          () => mockCheckUserCase.call(params: any(named: 'params')),
        ).thenAnswer((_) async => const Left('User not found'));
        return signUpCubit;
      },
      act: (cubit) => signUpCubit.userExist(email),
      expect: () =>
          [SignupLoading(), SignupFailureState(errorMessage: 'User not found')],
    );
  });

  group('Sign Up', () {
    final signupModel = SignupModel(
      bio: '123',
      courseId: '3333',
      email: 'example@gmail.com',
      name: 'pilong',
      password: '12345',
      username: 'long',
    );
    blocTest(
      'Emit[Loading, Loaded] State',
      build: () {
        when(
          () => mockSignupUseCase.call(params: any(named: 'params')),
        ).thenAnswer((_) async => const Right(true));
        return signUpCubit;
      },
      act: (cubit) => signUpCubit.signup(signupModel),
      expect: () => [SignupLoading(), SignupSuccessState(isSuccess: true)],
    );

    blocTest(
      'Emit[Loading, Failure] State',
      build: () {
        when(
          () => mockSignupUseCase.call(params: any(named: 'params')),
        ).thenAnswer((_) async => const Left('Sign up failed'));
        return signUpCubit;
      },
      act: (cubit) => signUpCubit.signup(signupModel),
      expect: () =>
          [SignupLoading(), SignupFailureState(errorMessage: 'Sign up failed')],
    );
  });
}
