import 'package:dartz/dartz.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/domain/auth/use_case/signup_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepository authRepository;
  late SignupUseCase signupUseCase;
  final sl = GetIt.instance;

  final mockSignup = SignupModel(
    bio: 'PI',
    username: 'pilong',
    email: 'pilong@gmail.com',
    name: 'Pi',
    password: '123456789',
    courseId: '1234567890',
  );

  setUp(() {
    authRepository = MockAuthRepository();
    sl.registerLazySingleton<AuthRepo>(() => authRepository);
    signupUseCase = SignupUseCase();
    registerFallbackValue(
      SignupModel(
        bio: 'PI',
        username: 'pilong',
        email: 'pilong@gmail.com',
        name: 'Pi',
        password: '123456789',
        courseId: '1234567890',
      ),
    );
  });

  tearDown(() {
    sl.reset();
  });

  test('success when return data', () async {
    when(() => authRepository.signup(any()))
        .thenAnswer((_) async => const Right('Register success'));

    final result = await signupUseCase(
      params: mockSignup,
    );

    expect(result, equals(const Right('Register success')));
    verify(() => authRepository.signup(mockSignup)).called(1);
  });

  test('failure when return error', () async {
    when(() => authRepository.signup(any()))
        .thenAnswer((_) async => const Left('Invalid credentials'));

    final result = await signupUseCase(
      params: mockSignup,
    );

    expect(result, equals(const Left('Invalid credentials')));
    verify(() => authRepository.signup(mockSignup)).called(1);
  });
}
