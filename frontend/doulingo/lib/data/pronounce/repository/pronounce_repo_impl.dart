import 'package:dartz/dartz.dart';
import 'package:doulingo/common/helpers/mapper/pronounce.dart';
import 'package:doulingo/data/pronounce/models/pronounce.dart';
import 'package:doulingo/data/pronounce/sources/pronounce_service.dart';
import 'package:doulingo/domain/pronounce/repository/pronounce_repo.dart';
import 'package:doulingo/service_locators.dart';

class PronounceRepoImpl extends PronounceRepository {
  @override
  Future<Either> getAllPronounce(String idCourse) async {
    final responseData = await sl<PronounceService>().getAllPronounce(idCourse);
    return responseData.fold(
      (error) => Left(error),
      (data) {
        final response = List.from(data)
            .map(
                (item) => PronounceMapper.toEntity(PronounceModel.toJson(item)))
            .toList();
        return Right(response);
      },
    );
  }
}
