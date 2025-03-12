import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/data/auth/source/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDioClient dioClient;
  late AuthService authService;
  final sl = GetIt.instance;

  setUp(() {
    dioClient = MockDioClient();
    if (!sl.isRegistered<DioClient>()) {
      sl.registerLazySingleton<DioClient>(() => dioClient);
    }
    authService = AuthServiceImpl();
  });

  tearDown(() {
    sl.reset();
  });

  group('Sign In', () {
    final signinModel = SigninModel(username: 'pilong', password: 'password');
    test('Case: Signin Success', () async {
      when(
        () => dioClient.post(
          ApiUrls.signin,
          data: signinModel.toMap(),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: '',
            data: {'message': 'Login success'},
          ),
        ),
      );

      final result = await authService.signin(signinModel);

      expect(result, isA<Right>());
      verify(() => dioClient.post(ApiUrls.signin, data: signinModel.toMap()))
          .called(1);
    });

    test('Case: Signin Failed', () async {
      when(() => dioClient.post(ApiUrls.signin, data: signinModel.toMap()))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(
              path: ApiUrls.signin,
              data: {'message': 'Invalid credentials'},
            ),
          ),
        ),
      );
      final result = await authService.signin(signinModel);
      expect(result, isA<Left>());
      verify(() => dioClient.post(ApiUrls.signin, data: signinModel.toMap()))
          .called(1);
    });
  });

  group('Sign Up', () {
    final mockSignup = SignupModel(
      bio: 'PI',
      username: 'pilong',
      email: 'pilong@gmail.com',
      name: 'Pi',
      password: '123456789',
      courseId: '1234567890',
    );

    test('Case: Signup Success', () async {
      when(
        () => dioClient.post(
          ApiUrls.register,
          data: mockSignup.toMap(),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: '',
            data: {'message': 'Register successful'},
          ),
        ),
      );

      final result = await authService.signup(mockSignup);
      expect(result, isA<Right>());
      verify(() => dioClient.post(ApiUrls.register, data: mockSignup.toMap()))
          .called(1);
    });

    test('Case: Signup Failure', () async {
      when(
        () => dioClient.post(
          ApiUrls.register,
          data: mockSignup.toMap(),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(
              path: ApiUrls.register,
              data: {'message': 'Invalid credentials'},
            ),
          ),
        ),
      );

      final result = await authService.signup(mockSignup);
      expect(result, isA<Left>());
      verify(() => dioClient.post(ApiUrls.register, data: mockSignup.toMap()))
          .called(1);
    });
  });

  group('Forgot Password', () {
    final mockEmail = SignupModel(
      email: 'email@example.com',
    );

    test('Case: Reset Password Success', () async {
      when(
        () => dioClient.post(
          ApiUrls.forgotPW,
          data: mockEmail.toMap(),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: '',
            data: {'message': 'Forgot Password Success'},
          ),
        ),
      );

      final result = await authService.forgotPW(mockEmail);

      expect(result, isA<Right>());
      verify(() => dioClient.post(ApiUrls.forgotPW, data: mockEmail.toMap()))
          .called(1);
    });

    test('Case: Reset Password Failure', () async {
      when(
        () => dioClient.post(
          ApiUrls.forgotPW,
          data: mockEmail.toMap(),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(
              path: ApiUrls.forgotPW,
              data: {'message': 'Invalid Credentials'},
            ),
          ),
        ),
      );

      final result = await authService.forgotPW(mockEmail);

      expect(result, isA<Left>());
      verify(() => dioClient.post(ApiUrls.forgotPW, data: mockEmail.toMap()))
          .called(1);
    });
  });

  group('Check User Exists', () {
    const email = 'email@example.com';

    test('Case: User Exist', () async {
      when(
        () => dioClient.post(
          ApiUrls.checkUser,
          data: {'email': email},
        ),
      ).thenAnswer(
        (_) async => Response(
          data: true,
          requestOptions: RequestOptions(
            path: '',
            data: true,
          ),
        ),
      );

      final result = await authService.checkEmail(email);

      expect(result, isTrue);
      verify(() => dioClient.post(ApiUrls.checkUser, data: {'email': email}))
          .called(1);
    });

    test('Case: User not Exist', () async {
      when(
        () => dioClient.post(
          ApiUrls.checkUser,
          data: {'email': email},
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(
              path: ApiUrls.checkUser,
              data: {'message': 'Invalids Credentials'},
            ),
          ),
        ),
      );

      expect(() async => await authService.checkEmail(email),
          throwsA(isA<Exception>()));
      verify(() => dioClient.post(ApiUrls.checkUser, data: {'email': email}))
          .called(1);
    });
  });
}
