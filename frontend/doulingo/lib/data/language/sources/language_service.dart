import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/service_locators.dart';

abstract class LanguageService {
  Future<Either> getAllLanguage();
  Future<Either> getCourseById(String id);
}

class LanguageServiceImpl extends LanguageService {
  @override
  Future<Either> getAllLanguage() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.getAllCourse,
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.message);
    }
  }

  @override
  Future<Either> getCourseById(String id) async {
    try {
      final token = await sl<GetDataUseCase>().call(
        params: 'access_token',
      );

      var response = await sl<DioClient>().get(
        '${ApiUrls.methodById}/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'token': 'Bearer $token',
          },
        ),
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.message);
    }
  }
}
