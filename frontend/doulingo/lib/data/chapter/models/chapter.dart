class ChapterModel {
  final String? avatar;
  final String? name;
  final String? title;
  final bool? isCompleted;
  final String? color;
  final dynamic courseId;
  final List<dynamic>? chapterContent;
  final List<dynamic>? lessons;

  ChapterModel({
    this.avatar,
    this.name,
    this.title,
    this.isCompleted,
    this.color,
    this.courseId,
    this.chapterContent,
    this.lessons,
  });

  factory ChapterModel.toJson(Map<String, dynamic> json) {
    return ChapterModel(
      avatar: json['avatar'],
      name: json['name'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      color: json['color'],
      courseId: json['courseId'],
      chapterContent: json['chapterContent'],
      lessons: json['lessons'],
    );
  }
}
