import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/section/sources/section_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDataUseCase extends Mock implements GetDataUseCase {}

class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockGetDataUseCase mockGetDataUseCase;
  late MockDioClient mockDioClient;
  late SectionService sectionService;
  final locator = GetIt.instance;

  setUp(() {
    mockGetDataUseCase = MockGetDataUseCase();
    mockDioClient = MockDioClient();

    locator.registerLazySingleton<GetDataUseCase>(() => mockGetDataUseCase);
    locator.registerLazySingleton<DioClient>(() => mockDioClient);
    sectionService = SectionServiceImpl();
  });

  tearDown(() {
    locator.reset();
  });

  group('Section Service', () {
    String idChapter = '123456';
    String token = 'access_token';
    String value = 'value';

    test('Case: Success', () async {
      when(
        () => mockGetDataUseCase.call(
          params: token,
        ),
      ).thenAnswer((_) async => value);

      when(
        () => mockDioClient.get(
          '${ApiUrls.getAllSection}/$idChapter',
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Get Section Success'},
          statusCode: 200,
        ),
      );

      final result = await sectionService.getAllSection(idChapter);

      expect(result, isA<Right>());
      verify(
        () => mockGetDataUseCase.call(
          params: token,
        ),
      ).called(1);
      verify(
        () => mockDioClient.get(
          '${ApiUrls.getAllSection}/$idChapter',
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    test('Case: Failure', () async {
      when(
        () => mockGetDataUseCase.call(
          params: token,
        ),
      ).thenAnswer((_) async => value);

      when(
        () => mockDioClient.get(
          '${ApiUrls.getAllSection}/$idChapter',
          options: any(named: 'options'),
        ),
      ).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Get Section Success'},
          statusCode: 200,
        ),
      ));

      final result = await sectionService.getAllSection(idChapter);

      expect(result, isA<Left>());
      verify(
        () => mockGetDataUseCase.call(
          params: token,
        ),
      ).called(1);
      verify(
        () => mockDioClient.get(
          '${ApiUrls.getAllSection}/$idChapter',
          options: any(named: 'options'),
        ),
      ).called(1);
    });
  });
}
