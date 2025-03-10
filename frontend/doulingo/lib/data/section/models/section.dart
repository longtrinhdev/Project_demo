class SectionModel {
  final String? id;
  final String? image;
  final String? name;
  final String? title;
  final String? color;
  final dynamic chapterId;
  final List<dynamic>? lessonIds;
  final List<dynamic>? sectionContent;

  SectionModel({
    this.id,
    this.image,
    this.name,
    this.title,
    this.color,
    this.chapterId,
    this.lessonIds,
    this.sectionContent,
  });

  factory SectionModel.toJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json["_id"],
      image: json['image'],
      name: json['name'],
      title: json['title'],
      color: json['color'],
      chapterId: json['chapterId'],
      lessonIds: json['lessonIds'],
      sectionContent: json['sectionContent'],
    );
  }
}
