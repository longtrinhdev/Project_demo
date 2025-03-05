import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/service_locators.dart';

class GetDataUseCase extends UseCase<String, String> {
  @override
  Future<String> call({String? params}) async {
    return await sl<LocalDataRepo>().getString(params!);
  }
}
