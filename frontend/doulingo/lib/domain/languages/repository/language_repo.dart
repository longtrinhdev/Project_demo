import 'package:dartz/dartz.dart';

abstract class LanguageRepository {
  Future<Either> getAllLanguage();
  Future<Either> getCourseById(String id);
}
