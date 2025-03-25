import 'package:doulingo/data/question/model/question.dart';
import 'package:doulingo/domain/question/entity/question.dart';

class QuestionMapper {
  static QuestionEntity toEntity(QuestionModel question) {
    return QuestionEntity(
      id: question.id,
      answer: question.answer,
      question: question.question,
      syllable: question.syllable,
      wrongAnswer: List<String>.from(question.wrongAnswer!),
    );
  }
}
