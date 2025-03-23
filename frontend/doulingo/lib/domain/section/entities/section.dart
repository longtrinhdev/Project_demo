import 'package:doulingo/domain/section/entities/lesson.dart';

class SectionEntity {
  final String? id;
  final String? image;
  final String? name;
  final String? title;
  final String? color;
  final dynamic chapter;
  final List<LessonEntity>? lessons;
  final List<dynamic>? sectionContent;

  SectionEntity({
    this.id,
    this.image,
    this.name,
    this.title,
    this.color,
    this.chapter,
    this.lessons,
    this.sectionContent,
  });
}
