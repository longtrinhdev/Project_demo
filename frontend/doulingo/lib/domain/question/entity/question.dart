class QuestionEntity {
  final String? id;
  final String? question;
  final String? answer;
  final List<String>? wrongAnswer;
  final dynamic syllable;

  QuestionEntity({
    this.id,
    this.question,
    this.answer,
    this.wrongAnswer,
    this.syllable,
  });
}
