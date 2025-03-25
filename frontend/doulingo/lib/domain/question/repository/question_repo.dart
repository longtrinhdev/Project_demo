import 'package:dartz/dartz.dart';

abstract class QuestionRepo {
  Future<Either> getQuestionsByIdLesson(List<String> lst);
}
