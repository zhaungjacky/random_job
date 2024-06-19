import 'package:shared_preferences/shared_preferences.dart';

class SharedModel {
  late SharedPreferences prefs;

  // static String ipKey() => "IP_Key";
  static String modeKey() => "Mode_key";
  static String emailKey() => "Email_key";
  // const SharedModel({required this.prefs});

  Future<bool> setItem(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  Future<String?> getItem(String key) async {
    prefs = await SharedPreferences.getInstance();
    final res = prefs.getString(key);
    return res;
  }

  Future<bool> removeItem(String key) async {
    prefs = await SharedPreferences.getInstance();
    final res = await prefs.remove(key);
    return res;
  }

  Future<bool> clearItems() async {
    prefs = await SharedPreferences.getInstance();
    final res = await prefs.clear();
    return res;
  }

  static Future<bool> setEmail(String? email) async {
    if (email == null) return false;
    final sharedModel = SharedModel();
    final currentEmail = await sharedModel.getItem(SharedModel.emailKey());
    if (currentEmail != null && currentEmail == email) {
      return true;
    } else if (currentEmail != null && currentEmail != email) {
      // await sharedModel.removeItem(SharedModel.ipKey);
      final res = await sharedModel.setItem(SharedModel.emailKey(), email);
      return res;
    } else {
      final res = await sharedModel.setItem(SharedModel.emailKey(), email);
      return res;
    }
  }

  static Future<String?> getEmail() async {
    final sharedModel = SharedModel();
    final email = await sharedModel.getItem(SharedModel.emailKey());
    return email;
  }
}
