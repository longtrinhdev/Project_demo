import 'package:dartz/dartz.dart';
import 'package:doulingo/common/helpers/mapper/chapter.dart';
import 'package:doulingo/data/chapter/models/chapter.dart';
import 'package:doulingo/data/chapter/sources/chapter_service.dart';
import 'package:doulingo/domain/chapter/repository/chapter_repo.dart';
import 'package:doulingo/service_locators.dart';

class ChapterRepoImpl extends ChapterRepo {
  @override
  Future<Either> getAllChapter(String idCourse) async {
    final response = await sl<ChapterService>().getAllChapter(idCourse);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        final response = List.from(data)
            .map((item) => ChapterMapper.toEntity(ChapterModel.toJson(item)))
            .toList();
        return Right(response);
      },
    );
  }

  @override
  Future<Either> getChapterById(String idChapter) async {
    final response = await sl<ChapterService>().getChapterById(idChapter);
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) {
        final chapter = ChapterMapper.toEntity(ChapterModel.toJson(data));
        return Right(chapter);
      },
    );
  }
}
