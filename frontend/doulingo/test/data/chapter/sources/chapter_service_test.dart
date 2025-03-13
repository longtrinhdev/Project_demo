import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/chapter/sources/chapter_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDataUseCase extends Mock implements GetDataUseCase {}

class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockGetDataUseCase mockGetDataUseCase;
  late MockDioClient mockDioClient;
  late ChapterService service;
  final locator = GetIt.instance;

  setUp(() {
    mockGetDataUseCase = MockGetDataUseCase();
    mockDioClient = MockDioClient();
    locator.registerLazySingleton<GetDataUseCase>(() => mockGetDataUseCase);
    locator.registerLazySingleton<DioClient>(() => mockDioClient);

    service = ChapterServiceImpl();
  });

  tearDown(() {
    locator.reset();
  });

  group('Get All Chapter', () {
    const idCourse = '123456';
    const mockToken = 'mockToken';
    test('Case: Success', () async {
      when(() => mockGetDataUseCase.call(
            params: 'access_token',
          )).thenAnswer((_) async => mockToken);
      when(
        () => mockDioClient.get(any(), options: any(named: 'options')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: '${ApiUrls.getAllChapter}/$idCourse',
            data: {'message': " Get All Chapter Success"},
          ),
          statusCode: 200,
        ),
      );

      final result = await service.getAllChapter(idCourse);

      expect(result, isA<Right>());
      verify(() => mockGetDataUseCase.call(params: 'access_token')).called(1);
      verify(
        () => mockDioClient.get('${ApiUrls.getAllChapter}/$idCourse',
            options: any(named: 'options')),
      ).called(1);
    });

    test('Case: Failure', () async {
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
            requestOptions: RequestOptions(
              path: '${ApiUrls.getAllChapter}/$idCourse',
            ),
            data: {'message': 'Invalid Credential'},
            statusCode: 500,
          ),
        ),
      );

      final result = await service.getAllChapter(idCourse);

      expect(result, isA<Left>());
      verify(() => mockGetDataUseCase.call(params: 'access_token')).called(1);
      verify(
        () => mockDioClient.get('${ApiUrls.getAllChapter}/$idCourse',
            options: any(named: 'options')),
      ).called(1);
    });
  });

  group('GetChapter By Id', () {
    const idChapter = '789012';
    const mockToken = 'mockToken';

    test('Case: Success', () async {
      when(() => mockGetDataUseCase.call(
            params: 'access_token',
          )).thenAnswer((_) async => mockToken);

      when(
        () => mockDioClient.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(
            path: '${ApiUrls.getChapterById}/$idChapter',
          ),
          data: {'message': " Get Chapter By Id Success"},
          statusCode: 200,
        ),
      );

      final result = await service.getChapterById(idChapter);

      expect(result, isA<Right>());
      verify(() => mockGetDataUseCase.call(params: 'access_token')).called(1);
      verify(
        () => mockDioClient.get('${ApiUrls.getChapterById}/$idChapter',
            options: any(named: 'options')),
      ).called(1);
    });

    test('Case: Failure', () async {
      when(() => mockGetDataUseCase.call(
            params: 'access_token',
          )).thenAnswer((_) async => mockToken);

      when(
        () => mockDioClient.get(
          any(),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(
              path: '${ApiUrls.getChapterById}/$idChapter',
            ),
            data: {'message': "Invalids Credentials"},
            statusCode: 500,
          ),
        ),
      );

      final result = await service.getChapterById(idChapter);

      expect(result, isA<Left>());
      verify(() => mockGetDataUseCase.call(params: 'access_token')).called(1);
      verify(
        () => mockDioClient.get('${ApiUrls.getChapterById}/$idChapter',
            options: any(named: 'options')),
      ).called(1);
    });
  });
}
