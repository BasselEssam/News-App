import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences= await SharedPreferences.getInstance();
  }

  static Future<bool?> setBool({required String key, required bool value}) async
  {
    return await sharedPreferences?.setBool(key, value);
  }

  static bool? getBool({required String key})
  {
    return sharedPreferences?.getBool(key);
  }

  static  Future<bool?> setInt({required String key,required int value})async
  {
    return await sharedPreferences?.setInt(key, value);
  }

  static int? getInt({required String key})
  {
    return sharedPreferences?.getInt(key);
  }
}