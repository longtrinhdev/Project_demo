import 'package:doulingo/common/helpers/mapper/lesson.dart';
import 'package:doulingo/data/section/models/section.dart';
import 'package:doulingo/domain/section/entities/section.dart';

class SectionMapper {
  static SectionEntity toEntity(SectionModel section) {
    return SectionEntity(
      id: section.id,
      name: section.name,
      title: section.title,
      image: section.image,
      color: section.color,
      chapter: section.chapter,
      lessons: section.lessons!
          .map((lesson) => LessonMapper.toEntity(lesson))
          .toList(),
      sectionContent: section.sectionContent,
    );
  }
}
