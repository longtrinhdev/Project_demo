import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/service_locators.dart';

class CheckUserUseCase extends UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<AuthRepo>().checkUser(params!);
  }
}
