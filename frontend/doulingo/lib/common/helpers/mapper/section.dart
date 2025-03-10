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
      chapterId: section.chapterId,
      lessonIds: section.lessonIds,
      sectionContent: section.sectionContent,
    );
  }
}
