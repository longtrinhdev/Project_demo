import 'package:dartz/dartz.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/service_locators.dart';

class GetLanguageUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<LanguageRepository>().getCourseById(params!);
  }
}
