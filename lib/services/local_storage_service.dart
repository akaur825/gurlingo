import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String userKey = "user";

  static Future<void> saveUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();

    final user = {
      "name": name,
      "email": email,
      "isLoggedIn": true,
    };

    await prefs.setString(userKey, jsonEncode(user));
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(userKey);

    if (data == null) return null;

    return jsonDecode(data);
  }

  static Future<bool> isLoggedIn() async {
    final user = await getUser();
    return user?["isLoggedIn"] == true;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // This wipes the saved name and email so isAuth becomes false
    await prefs.clear(); 
  }
}