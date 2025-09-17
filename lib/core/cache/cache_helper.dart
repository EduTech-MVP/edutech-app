import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  //intialize of chache
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //put data in local database using key
  String? getdataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  // get data already saved in local database
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // remove data using specific key
  dynamic removeData({required String key}) {
    return sharedPreferences.remove(key);
  }

  // check if local database contains key
  dynamic containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  // clear all  data in the local database
  dynamic clearData() {
    return sharedPreferences.clear();
  }
}
