import 'package:dartz/dartz.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/service_locators.dart';

class GetAllLanguageUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<LanguageRepository>().getAllLanguage();
  }
}
