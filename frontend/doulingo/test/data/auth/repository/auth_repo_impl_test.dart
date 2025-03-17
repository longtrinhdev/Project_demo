import 'package:dartz/dartz.dart';
import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/data/auth/models/user.dart';
import 'package:doulingo/data/auth/repository/auth_repo_impl.dart';
import 'package:doulingo/data/auth/source/auth_service.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockLocalDataRepo extends Mock implements LocalDataRepo {}

void main() {
  late AuthRepo authRepo;
  late MockAuthService authService;
  late MockLocalDataRepo localDataRepo;
  final locator = GetIt.instance;

  setUp(() {
    authService = MockAuthService();
    localDataRepo = MockLocalDataRepo();

    locator.registerLazySingleton<AuthService>(() => authService);
    locator.registerLazySingleton<LocalDataRepo>(() => localDataRepo);
    registerFallbackValue(SigninModel(
      username: 'username',
      password: 'password',
    ));
    registerFallbackValue(
      SharedReq(
        key: 'access_token',
        value: 'mock_access_token',
      ),
    );
    registerFallbackValue(
      SignupModel(),
    );
    authRepo = AuthRepoImpl();
  });

  tearDown(() {
    locator.reset();
  });

  group('Sign In', () {
    final userModel = UserModel(
      bio: 'Pi',
      courseId: ['1234567890'],
      email: 'example@example.com',
      followers: [],
      followings: [],
      id: '12345678',
      learnDays: [],
      score: 0,
      name: 'nam',
      username: 'pilong',
    );
    final mockResponse = {
      "user": {
        "id": userModel.id,
        "bio": userModel.bio,
        "email": userModel.email,
        "courseId": userModel.courseId,
        "followers": userModel.followers,
        "followings": userModel.followings,
        "learnDays": userModel.learnDays,
        "score": userModel.score,
        "username": userModel.username,
        "name": userModel.name,
      },
      "accessToken": "mock_access_token",
      "refreshToken": "mock_refresh_token",
    };
    final signinModel = SigninModel(username: 'username', password: 'password');
    test('Case: Success', () async {
      when(() => authService.signin(any()))
          .thenAnswer((_) async => Right(mockResponse));

      when(() => localDataRepo.setString(any()))
          .thenAnswer((_) async => Future.value());

      final result = await authRepo.signin(signinModel);

      expect(result.isRight(), true);

      verify(() => localDataRepo.setString(any())).called(2);
    });

    test("Case: Failure", () async {
      when(() => authService.signin(any()))
          .thenAnswer((_) async => const Left("Invalid credentials"));

      final result = await authRepo.signin(signinModel);

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => null), equals("Invalid credentials"));

      verify(() => authService.signin(signinModel)).called(1);
      verifyNever(() => localDataRepo.setString(any()));
    });
  });

  group('Signup', () {
    const mockMessage = 'Register successfully';
    final mockSignUp = SignupModel(
      bio: 'PI',
      username: 'pilong',
      email: 'pilong@gmail.com',
      name: 'Pi',
      password: '123456789',
      courseId: '1234567890',
    );
    test('Case: Success', () async {
      when(() => authService.signup(any())).thenAnswer(
        (_) async => const Right(mockMessage),
      );

      final result = await authRepo.signup(mockSignUp);

      expect(result, isA<Right>());
      expect(result.fold((l) => null, (r) => r), equals(mockMessage));
      verify(() => authService.signup(mockSignUp)).called(1);
    });

    test('Case: Failure', () async {
      when(() => authService.signup(any())).thenAnswer(
        (_) async => const Left('Invalid credentials'),
      );

      final result = await authRepo.signup(mockSignUp);

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => null), equals('Invalid credentials'));
      verify(() => authService.signup(mockSignUp)).called(1);
    });
  });

  group('Forgot Password', () {
    final mockSignUp = SignupModel(email: 'pilong@gmail.com');

    test('Case: Success', () async {
      when(() => authService.forgotPW(any()))
          .thenAnswer((_) async => const Right('Reset Password Success'));

      final result = await authRepo.forgotPW(mockSignUp);

      expect(result, isA<Right>());
      expect(
          result.fold((l) => null, (r) => r), equals('Reset Password Success'));
      verify(() => authService.forgotPW(mockSignUp)).called(1);
    });

    test('Case: Failure', () async {
      when(() => authService.forgotPW(any()))
          .thenAnswer((_) async => const Left('Invalid credentials'));

      final result = await authRepo.forgotPW(mockSignUp);

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => null), equals('Invalid credentials'));
      verify(() => authService.forgotPW(mockSignUp)).called(1);
    });
  });

  group('Check User Exits', () {
    const email = 'emails@example.com';

    test('Case: Success When true', () async {
      when(() => authService.checkEmail(any()))
          .thenAnswer((_) async => const Right(true));

      final result = await authRepo.checkUser(email);

      expect(result, const Right(true));
      verify(() => authService.checkEmail(email)).called(1);
    });

    test('Case: Success when false', () async {
      when(() => authService.checkEmail(any()))
          .thenAnswer((_) async => const Left('Invalid credentials'));

      final result = await authRepo.checkUser(email);

      expect(result, const Left('Invalid credentials'));
      verify(() => authService.checkEmail(email)).called(1);
    });
  });
}
