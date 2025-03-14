import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/pronounce/sources/pronounce_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDataUseCase extends Mock implements GetDataUseCase {}

class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockGetDataUseCase mockGetDataUseCase;
  late MockDioClient mockDioClient;
  late PronounceService pronounceService;
  final locator = GetIt.instance;

  setUp(() {
    mockGetDataUseCase = MockGetDataUseCase();
    mockDioClient = MockDioClient();
    locator.registerLazySingleton<GetDataUseCase>(() => mockGetDataUseCase);
    locator.registerLazySingleton<DioClient>(() => mockDioClient);
    pronounceService = PronounceServiceImpl();
  });

  tearDown(() {
    locator.reset();
  });

  group('Pronounce Service', () {
    String idCourse = '123456';
    String accessToken = 'access_token';
    String valueToken = 'value_token';
    test('Case: Success', () async {
      when(() => mockGetDataUseCase.call(
            params: accessToken,
          )).thenAnswer((_) async => valueToken);

      when(
        () => mockDioClient.get(
          '${ApiUrls.getAllSyllable}/$idCourse',
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Get Data Success'},
          statusCode: 200,
        ),
      );

      final result = await pronounceService.getAllPronounce(idCourse);

      expect(result, isA<Right>());
      verify(() => mockGetDataUseCase.call(params: accessToken)).called(1);
      verify(
        () => mockDioClient.get(
          '${ApiUrls.getAllSyllable}/$idCourse',
          options: any(named: 'options'),
        ),
      );
    });

    test('Case: Failure', () async {
      when(() => mockGetDataUseCase.call(
            params: accessToken,
          )).thenAnswer((_) async => valueToken);

      when(
        () => mockDioClient.get(
          '${ApiUrls.getAllSyllable}/$idCourse',
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': 'Invalid Credentials'},
            statusCode: 500,
          ),
        ),
      );

      final result = await pronounceService.getAllPronounce(idCourse);

      expect(result, isA<Left>());
      verify(() => mockGetDataUseCase.call(params: accessToken)).called(1);
      verify(
        () => mockDioClient.get(
          '${ApiUrls.getAllSyllable}/$idCourse',
          options: any(named: 'options'),
        ),
      );
    });
  });
}
