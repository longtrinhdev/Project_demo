import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/service_locators.dart';

abstract class QuestionService {
  Future<Either> getQuestionsIdLesson(List<String> lst);
}

class QuestionServiceImpl extends QuestionService {
  @override
  Future<Either> getQuestionsIdLesson(List<String> lst) async {
    try {
      final accessToken = await sl<GetDataUseCase>().call(
        params: 'access_token',
      );
      final sectionId = lst.first;
      final lessonId = lst.last;
      final responseData = await sl<DioClient>().get(
        '${ApiUrls.questionsByIdLesson}/$sectionId?lessonId=$lessonId',
        options: Options(
          headers: {
            'token': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      return Right(responseData.data);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }
}
