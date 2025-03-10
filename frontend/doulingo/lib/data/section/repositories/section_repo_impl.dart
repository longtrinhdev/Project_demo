import 'package:dartz/dartz.dart';
import 'package:doulingo/common/helpers/mapper/section.dart';
import 'package:doulingo/data/section/models/section.dart';
import 'package:doulingo/data/section/sources/section_service.dart';
import 'package:doulingo/domain/section/repositories/section_repo.dart';
import 'package:doulingo/service_locators.dart';

class SectionRepoImpl extends SectionRepository {
  @override
  Future<Either> getAllSections(String idChapter) async {
    final responseData = await sl<SectionService>().getAllSection(idChapter);
    return responseData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        final response = List.from(data)
            .map((item) => SectionMapper.toEntity(SectionModel.toJson(item)))
            .toList();
        return Right(response);
      },
    );
  }
}
