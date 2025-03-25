class LessonEntity {
  final String? id;
  final String? title;
  final bool? isCompleted;
  final bool? isUnlocked;
  final List<dynamic>? questions;

  LessonEntity({
    this.id,
    this.title,
    this.isCompleted,
    this.isUnlocked,
    this.questions,
  });
}
