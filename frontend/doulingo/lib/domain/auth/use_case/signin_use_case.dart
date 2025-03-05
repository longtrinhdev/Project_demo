import 'package:dartz/dartz.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/service_locators.dart';

class SigninUseCase extends UseCase<Either, SigninModel> {
  @override
  Future<Either> call({SigninModel? params}) async {
    return await sl<AuthRepo>().signin(params!);
  }
}
