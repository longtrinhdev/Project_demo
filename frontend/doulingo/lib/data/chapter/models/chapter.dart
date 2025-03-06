class ChapterModel {
  final String? id;
  final String? avatar;
  final String? name;
  final String? title;
  final bool? isCompleted;
  final bool? isUnlocked;
  final String? color;
  final dynamic courseId;
  final List<dynamic>? chapterContent;
  final List<dynamic>? lessons;

  ChapterModel({
    this.id,
    this.avatar,
    this.name,
    this.title,
    this.isCompleted,
    this.isUnlocked,
    this.color,
    this.courseId,
    this.chapterContent,
    this.lessons,
  });

  factory ChapterModel.toJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['_id'],
      avatar: json['avatar'],
      name: json['name'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      isUnlocked: json['isUnlocked'],
      color: json['color'],
      courseId: json['courseId'],
      chapterContent: json['chapterContent'],
      lessons: json['lessons'],
    );
  }
}
