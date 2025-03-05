import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/service_locators.dart';

class RemoveDataUseCase extends UseCase<void, dynamic> {
  @override
  Future<void> call({params}) async {
    await sl<LocalDataRepo>().removeData();
  }
}
