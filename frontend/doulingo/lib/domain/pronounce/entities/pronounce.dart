class PronounceEntity {
  final String? id;
  final String? word;
  final String? example;
  final String? audio;
  final String? video;
  final String? image;
  final String? manual;
  final List<dynamic>? questionId;
  final dynamic courseId;

  PronounceEntity({
    this.id,
    this.word,
    this.example,
    this.audio,
    this.video,
    this.image,
    this.manual,
    this.questionId,
    this.courseId,
  });
}
