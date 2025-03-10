import 'package:dartz/dartz.dart';

abstract class PronounceRepository {
  Future<Either> getAllPronounce(String idCourse);
}
