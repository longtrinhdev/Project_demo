import 'package:dartz/dartz.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SigninUseCase signinUseCase;
  final sl = GetIt.instance;
  final mockSigninModel = SigninModel(
    username: 'long_pi',
    password: '12345678',
  );

  setUp(() {
    sl.reset();
    mockAuthRepository = MockAuthRepository();
    sl.registerLazySingleton<AuthRepo>(() => mockAuthRepository);
    signinUseCase = SigninUseCase();
    registerFallbackValue(
        SigninModel(username: 'username', password: 'password'));
  });

  test('success when return data', () async {
    when(() => mockAuthRepository.signin(any()))
        .thenAnswer((_) async => const Right('Signin success'));
    final result = await signinUseCase(
      params: mockSigninModel,
    );

    expect(result, equals(const Right('Signin success')));
    verify(() => mockAuthRepository.signin(mockSigninModel)).called(1);
  });

  test('failed when return error', () async {
    when(() => mockAuthRepository.signin(any()))
        .thenAnswer((_) async => const Left('Invalid credentials'));

    final result = await signinUseCase(params: mockSigninModel);
    expect(result, equals(const Left('Invalid credentials')));
    verify(() => mockAuthRepository.signin(mockSigninModel)).called(1);
  });
}
