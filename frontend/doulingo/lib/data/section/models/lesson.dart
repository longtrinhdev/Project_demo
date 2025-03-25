class LessonModel {
  final String? id;
  final String? title;
  final bool? isCompleted;
  final bool? isUnlocked;
  final List<dynamic>? questions;

  LessonModel({
    this.id,
    this.title,
    this.isCompleted,
    this.isUnlocked,
    this.questions,
  });

  factory LessonModel.toJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['_id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      isUnlocked: json['isUnlocked'],
      questions: json['questions'],
    );
  }
}
