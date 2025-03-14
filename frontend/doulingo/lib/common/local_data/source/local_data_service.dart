import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataService {
  Future<String> getString(String key);
  Future<void> setString(SharedReq sharedReq);
  Future<void> removeShared();
}

class LocalDataServiceImpl extends LocalDataService {
  final SharedPreferences sharedPreferences;
  LocalDataServiceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<String> getString(String key) async {
    return sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<void> removeShared() async {
    await sharedPreferences.clear();
  }

  @override
  Future<void> setString(SharedReq sharedReq) async {
    await sharedPreferences.setString(sharedReq.key, sharedReq.value);
  }
}
