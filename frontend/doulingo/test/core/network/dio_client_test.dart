import 'package:dio/dio.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late DioClient dioClient;

  setUp(() {
    mockDio = MockDio();
    dioClient = DioClient();
  });

  group('DioClient GET request', () {
    test('Call Api Failed', () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
          data: {'message': 'Bad Request'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        ),
      ).thenThrow(dioError);

      expect(() => dioClient.get('/test'), throwsA(isA<DioException>()));
    });
  });
}
