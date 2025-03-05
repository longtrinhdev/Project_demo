import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/service_locators.dart';

abstract class LanguageService {
  Future<Either> getAllLanguage();
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
      return Left(error.response!.data['message']);
    }
  }
}
