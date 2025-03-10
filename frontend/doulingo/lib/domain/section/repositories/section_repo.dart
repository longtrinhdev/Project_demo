import 'package:dartz/dartz.dart';

abstract class SectionRepository {
  Future<Either> getAllSections(String idChapter);
}
