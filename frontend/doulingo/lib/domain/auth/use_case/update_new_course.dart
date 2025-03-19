import 'package:dartz/dartz.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/service_locators.dart';

class UpdateNewCourseUC extends UseCase<Either, SignupModel> {
  @override
  Future<Either> call({SignupModel? params}) async {
    return await sl<AuthRepo>().upCourseId(params!);
  }
}
