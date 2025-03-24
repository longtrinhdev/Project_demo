import 'package:dartz/dartz.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/domain/question/repository/question_repo.dart';
import 'package:doulingo/service_locators.dart';

class GetAllQuestionUc extends UseCase<Either, List<String>> {
  @override
  Future<Either> call({List<String>? params}) async {
    return await sl<QuestionRepo>().getQuestionsByIdLesson(params!);
  }
}
