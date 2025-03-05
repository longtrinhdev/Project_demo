import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/service_locators.dart';

abstract class ChapterService {
  Future<Either> getChapterById(String idCourse);
}

class ChapterServiceImpl extends ChapterService {
  @override
  Future<Either> getChapterById(String idCourse) async {
    try {
      final token = await sl<GetDataUseCase>().call(
        params: 'access_token',
      );
      final responseData = await sl<DioClient>().get(
        '${ApiUrls.getAllChapter}/$idCourse',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'token': 'Bearer $token',
          },
        ),
      );
      return Right(responseData.data);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }
}
