import 'package:dartz/dartz.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/domain/auth/use_case/forgot_pw.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late ForgotPwUseCase forgotPwUseCase;
  final locator = GetIt.instance;
  final mockEmail = SignupModel(
    email: 'email@example.com',
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    locator.registerLazySingleton<AuthRepo>(() => mockAuthRepository);
    forgotPwUseCase = ForgotPwUseCase();
    registerFallbackValue(SignupModel(
      email: 'email@example.com',
    ));
  });

  tearDown(() {
    locator.reset();
  });

  test('success when send email success', () async {
    when(() => mockAuthRepository.forgotPW(any()))
        .thenAnswer((_) async => const Right('Send email success'));

    final result = await forgotPwUseCase.call(
      params: mockEmail,
    );

    expect(result, equals(const Right('Send email success')));
  });

  test('failure when send email failed', () async {
    when(() => mockAuthRepository.forgotPW(any()))
        .thenAnswer((_) async => const Left('Reset password failed'));

    final result = await forgotPwUseCase.call(
      params: mockEmail,
    );

    expect(result, equals(const Left('Reset password failed')));
  });
}
