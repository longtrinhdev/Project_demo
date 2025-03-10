import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/service_locators.dart';

abstract class SectionService {
  Future<Either> getAllSection(String idChapter);
}

class SectionServiceImpl extends SectionService {
  @override
  Future<Either> getAllSection(String idChapter) async {
    try {
      final accessToken = await sl<GetDataUseCase>().call(
        params: 'access_token',
      );
      final response = await sl<DioClient>().get(
        '${ApiUrls.getAllSection}/$idChapter',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Token': 'Bearer $accessToken',
        }),
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.message);
    }
  }
}
