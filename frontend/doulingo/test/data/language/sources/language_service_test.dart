import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/language/sources/language_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClient extends Mock implements DioClient {}

class MockGetDataUseCase extends Mock implements GetDataUseCase {}

void main() {
  late MockDioClient mockDioClient;
  late MockGetDataUseCase mockGetDataUseCase;
  late LanguageService languageService;
  final locator = GetIt.instance;

  setUp(() {
    mockDioClient = MockDioClient();
    mockGetDataUseCase = MockGetDataUseCase();
    languageService = LanguageServiceImpl();
    locator.registerLazySingleton<DioClient>(() => mockDioClient);
    locator.registerLazySingleton<GetDataUseCase>(() => mockGetDataUseCase);
  });

  tearDown(() {
    locator.reset();
  });

  group('Get All Language', () {
    test('Success when return data', () async {
      when(
        () => mockDioClient.get(
          ApiUrls.getAllCourse,
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: '',
            data: {'message': 'Get Data Success'},
          ),
        ),
      );

      final result = await languageService.getAllLanguage();
      expect(result, isA<Right>());
      verify(
        () => mockDioClient.get(
          ApiUrls.getAllCourse,
        ),
      ).called(1);
    });

    test('Failure when return error message', () async {
      when(
        () => mockDioClient.get(
          ApiUrls.getAllCourse,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(
              path: ApiUrls.getAllCourse,
              data: {'message': 'Invalid Credentials'},
            ),
          ),
        ),
      );

      final result = await languageService.getAllLanguage();
      expect(result, isA<Left>());
      verify(
        () => mockDioClient.get(
          ApiUrls.getAllCourse,
        ),
      ).called(1);
    });
  });

  group('Get course by id', () {
    const idCourse = '1234567';
    const mockToken = 'mock-token';
    test('Success when return data', () async {
      when(
        () => mockGetDataUseCase.call(
          params: 'access_token',
        ),
      ).thenAnswer((_) async => mockToken);

      when(
        () => mockDioClient.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions:
              RequestOptions(path: '${ApiUrls.methodById}/$idCourse'),
          data: {'message': 'Get data success'},
          statusCode: 200,
        ),
      );

      final result = await languageService.getCourseById(idCourse);

      expect(result, isA<Right>());
      verify(
        () => mockGetDataUseCase.call(
          params: 'access_token',
        ),
      ).called(1);
      verify(() => mockDioClient.get(
            '${ApiUrls.methodById}/$idCourse',
            options: any(named: 'options'),
          )).called(1);
    });

    test('Failed when return error message', () async {
      when(
        () => mockGetDataUseCase.call(
          params: 'access_token',
        ),
      ).thenAnswer((_) async => mockToken);

      when(
        () => mockDioClient.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions:
                RequestOptions(path: '${ApiUrls.methodById}/$idCourse'),
            data: {'message': 'Invalid Credentials'},
            statusCode: 500,
          ),
        ),
      );

      final result = await languageService.getCourseById(idCourse);

      expect(result, isA<Left>());
      verify(
        () => mockGetDataUseCase.call(
          params: 'access_token',
        ),
      ).called(1);
      verify(() => mockDioClient.get(
            '${ApiUrls.methodById}/$idCourse',
            options: any(named: 'options'),
          )).called(1);
    });
  });
}
