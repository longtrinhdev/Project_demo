import 'package:doulingo/data/section/models/lesson.dart';

class SectionModel {
  final String? id;
  final String? image;
  final String? name;
  final String? title;
  final String? color;
  final dynamic chapter;
  final List<LessonModel>? lessons;
  final List<dynamic>? sectionContent;

  SectionModel({
    this.id,
    this.image,
    this.name,
    this.title,
    this.color,
    this.chapter,
    this.lessons,
    this.sectionContent,
  });

  factory SectionModel.toJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json["_id"],
      image: json['image'],
      name: json['name'],
      title: json['title'],
      color: json['color'],
      chapter: json['chapter'],
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((lesson) => LessonModel.toJson(lesson))
          .toList(),
      sectionContent: json['sectionContent'],
    );
  }
}
