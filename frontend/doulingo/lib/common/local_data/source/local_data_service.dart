import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataService {
  Future<String> getString(String key);
  Future<void> setString(SharedReq sharedReq);
  Future<void> removeShared();
}

class LocalDataServiceImpl extends LocalDataService {
  @override
  Future<String> getString(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(key)!;
  }

  @override
  Future<void> removeShared() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  @override
  Future<void> setString(SharedReq sharedReq) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(sharedReq.key, sharedReq.value);
  }
}
