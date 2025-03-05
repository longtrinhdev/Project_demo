import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/source/local_data_service.dart';
import 'package:doulingo/service_locators.dart';

abstract class LocalDataRepo {
  Future<String> getString(String key);
  Future<void> setString(SharedReq sharedReq);
  Future<void> removeData();
}

class LocalDataRepoImpl extends LocalDataRepo {
  @override
  Future<String> getString(String key) async {
    final responseData = await sl<LocalDataService>().getString(key);
    return responseData;
  }

  @override
  Future<void> removeData() async {
    await sl<LocalDataService>().removeShared();
  }

  @override
  Future<void> setString(SharedReq sharedReq) async {
    await sl<LocalDataService>().setString(sharedReq);
  }
}
