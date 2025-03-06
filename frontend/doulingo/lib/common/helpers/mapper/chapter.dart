import 'package:doulingo/data/chapter/models/chapter.dart';
import 'package:doulingo/domain/chapter/entities/chapter.dart';

class ChapterMapper {
  static ChapterEntity toEntity(ChapterModel chapterModel) {
    return ChapterEntity(
      id: chapterModel.id,
      name: chapterModel.name,
      avatar: chapterModel.avatar,
      color: chapterModel.color,
      courseId: chapterModel.courseId,
      isCompleted: chapterModel.isCompleted,
      isUnlocked: chapterModel.isUnlocked,
      title: chapterModel.title,
      lessons: chapterModel.lessons,
      chapterContent: chapterModel.chapterContent,
    );
  }
}
