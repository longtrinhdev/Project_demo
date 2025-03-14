import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/source/local_data_service.dart';

abstract class LocalDataRepo {
  Future<String> getString(String key);
  Future<void> setString(SharedReq sharedReq);
  Future<void> removeData();
}

class LocalDataRepoImpl extends LocalDataRepo {
  final LocalDataService localDataService;

  LocalDataRepoImpl({required this.localDataService});

  @override
  Future<String> getString(String key) async {
    final responseData = await localDataService.getString(key);
    return responseData;
  }

  @override
  Future<void> removeData() async {
    await localDataService.removeShared();
  }

  @override
  Future<void> setString(SharedReq sharedReq) async {
    await localDataService.setString(sharedReq);
  }
}
