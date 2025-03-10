class SectionEntity {
  final String? id;
  final String? image;
  final String? name;
  final String? title;
  final String? color;
  final dynamic chapterId;
  final List<dynamic>? lessonIds;
  final List<dynamic>? sectionContent;

  SectionEntity({
    this.id,
    this.image,
    this.name,
    this.title,
    this.color,
    this.chapterId,
    this.lessonIds,
    this.sectionContent,
  });
}
