import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late CheckUserUseCase checkUserUseCase;
  final locator = GetIt.instance;
  const email = 'email@example.com';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    checkUserUseCase = CheckUserUseCase();
    locator.registerLazySingleton<AuthRepo>(() => mockAuthRepository);
  });

  tearDown(() {
    locator.reset();
  });

  test('success when return true', () async {
    const mockData = true;
    when(() => mockAuthRepository.checkUser(any()))
        .thenAnswer((_) async => const Right(mockData));

    final result = await checkUserUseCase.call(
      params: email,
    );

    expect(result, equals(const Right(mockData)));
    verify(() => mockAuthRepository.checkUser(email)).called(1);
  });

  test('success when return false', () async {
    when(() => mockAuthRepository.checkUser(any()))
        .thenAnswer((_) async => const Left('Invalid Credentials'));

    final result = await checkUserUseCase.call(
      params: email,
    );

    expect(result, equals(const Left('Invalid Credentials')));
    verify(() => mockAuthRepository.checkUser(email)).called(1);
  });
}
