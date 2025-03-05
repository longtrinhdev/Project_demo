import 'package:dartz/dartz.dart';

abstract class ChapterRepo {
  Future<Either> getChapterById(String idCourse);
}
