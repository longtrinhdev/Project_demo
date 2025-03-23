import 'package:doulingo/data/section/models/lesson.dart';
import 'package:doulingo/domain/section/entities/lesson.dart';

class LessonMapper {
  static LessonEntity toEntity(LessonModel lesson) {
    return LessonEntity(
      id: lesson.id,
      title: lesson.title,
      isCompleted: lesson.isCompleted,
      isUnlocked: lesson.isUnlocked,
      questions: lesson.questions,
    );
  }
}
