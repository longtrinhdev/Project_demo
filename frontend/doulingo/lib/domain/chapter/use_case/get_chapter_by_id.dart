import 'package:dartz/dartz.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/domain/chapter/repository/chapter_repo.dart';
import 'package:doulingo/service_locators.dart';

class GetChapterByIdUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ChapterRepo>().getChapterById(params!);
  }
}
