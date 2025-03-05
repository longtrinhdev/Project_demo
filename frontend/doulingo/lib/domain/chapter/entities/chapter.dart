class ChapterEntity {
  final String? avatar;
  final String? name;
  final String? title;
  final bool? isCompleted;
  final String? color;
  final dynamic courseId;
  final List<dynamic>? chapterContent;
  final List<dynamic>? lessons;

  ChapterEntity({
    this.avatar,
    this.name,
    this.title,
    this.isCompleted,
    this.color,
    this.courseId,
    this.chapterContent,
    this.lessons,
  });
}
