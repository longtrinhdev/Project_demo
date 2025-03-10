import 'package:doulingo/data/pronounce/models/pronounce.dart';
import 'package:doulingo/domain/pronounce/entities/pronounce.dart';

class PronounceMapper {
  static PronounceEntity toEntity(PronounceModel pronounce) {
    return PronounceEntity(
      id: pronounce.id,
      word: pronounce.word,
      audio: pronounce.audio,
      courseId: pronounce.courseId,
      example: pronounce.example,
      image: pronounce.image,
      manual: pronounce.manual,
      video: pronounce.video,
      questionId: pronounce.questionId,
    );
  }
}
