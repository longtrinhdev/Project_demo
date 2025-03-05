import 'package:dartz/dartz.dart';
import 'package:doulingo/common/helpers/mapper/language.dart';
import 'package:doulingo/data/language/models/language.dart';
import 'package:doulingo/data/language/sources/language_service.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/service_locators.dart';

class LanguageRepoImpl extends LanguageRepository {
  @override
  Future<Either> getAllLanguage() async {
    var responseData = await sl<LanguageService>().getAllLanguage();

    return responseData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        final languages = List.from(data)
            .map(
                (item) => LanguageMapper.toEntity(LanguageModel.fromJson(item)))
            .toList();
        return Right(languages);
      },
    );
  }
}
