import 'package:dartz/dartz.dart';

abstract class ChapterRepo {
  Future<Either> getAllChapter(String idCourse);
  Future<Either> getChapterById(String idChapter);
}
