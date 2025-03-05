import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/service_locators.dart';

class SetDataUseCase extends UseCase<void, SharedReq> {
  @override
  Future<void> call({SharedReq? params}) async {
    await sl<LocalDataRepo>().setString(params!);
  }
}
