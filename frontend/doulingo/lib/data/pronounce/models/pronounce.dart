class PronounceModel {
  final String? id;
  final String? word;
  final String? example;
  final String? audio;
  final String? video;
  final String? image;
  final String? manual;
  final List<dynamic>? questionId;
  final dynamic courseId;

  PronounceModel({
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

  factory PronounceModel.toJson(Map<String, dynamic> json) {
    return PronounceModel(
      id: json['_id'],
      word: json['word'],
      example: json['example'],
      audio: json['audio'],
      video: json['video'],
      image: json['image'],
      manual: json['manual'],
      questionId: json['questionId'],
      courseId: json['courseId'],
    );
  }
}
