class ChapterEntity {
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

  ChapterEntity({
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
}
