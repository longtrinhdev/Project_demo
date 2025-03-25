class QuestionModel {
  final String? id;
  final String? question;
  final String? answer;
  final List<String>? wrongAnswer;
  final dynamic syllable;

  QuestionModel({
    this.id,
    this.question,
    this.answer,
    this.wrongAnswer,
    this.syllable,
  });

  factory QuestionModel.toJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
      wrongAnswer: List<String>.from(json['wrongAnswer']),
      syllable: json['syllable'],
    );
  }
}
