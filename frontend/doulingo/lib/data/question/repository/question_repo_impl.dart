import 'package:dartz/dartz.dart';
import 'package:doulingo/common/helpers/mapper/question.dart';
import 'package:doulingo/data/question/model/question.dart';
import 'package:doulingo/data/question/source/question_service.dart';
import 'package:doulingo/domain/question/repository/question_repo.dart';
import 'package:doulingo/service_locators.dart';

class QuestionRepoImpl extends QuestionRepo {
  @override
  Future<Either> getQuestionsByIdLesson(List<String> lst) async {
    final responseData = await sl<QuestionService>().getQuestionsIdLesson(lst);
    return responseData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        final response = List.from(data)
            .map((question) =>
                QuestionMapper.toEntity(QuestionModel.toJson(question)))
            .toList();
        return Right(response);
      },
    );
  }
}
