import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String allUsersKey = "all_users";
  static const String currentUserKey = "current_user";

  // 1. SAVE NEW USER (Sign Up) - With duplicate check
  static Future<bool> saveUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> usersList = await getAllUsers();

    // Check if email already exists
    bool emailExists = usersList.any((user) => user['email'] == email);
    if (emailExists) {
      return false; // Registration failed because user exists
    }

    final newUser = {
      "name": name,
      "email": email,
      "password": password,
    };

    usersList.add(newUser);
    await prefs.setString(allUsersKey, jsonEncode(usersList));
    await setCurrentUser(name, email);
    return true; // Successfully registered
  }

  // 2. HELPER: Get all created users
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(allUsersKey);
    if (data == null) return [];
    
    List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  // 3. VALIDATE LOGIN
  static Future<Map<String, dynamic>?> authenticateUser(String email, String password) async {
    List<Map<String, dynamic>> users = await getAllUsers();

    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        await setCurrentUser(user['name'], user['email']);
        return user;
      }
    }
    return null; 
  }

  // 4. SESSION MANAGEMENT
  static Future<void> setCurrentUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    final activeUser = {
      "name": name,
      "email": email,
      "isLoggedIn": true,
    };
    await prefs.setString(currentUserKey, jsonEncode(activeUser));
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(currentUserKey);
    if (data == null) return null;
    return jsonDecode(data);
  }

// Fetch an existing progress profile map by email/username
static Future<Map<String, dynamic>?> getUserProgress(String email) async {
  List<Map<String, dynamic>> users = await getAllUsers();
  for (var user in users) {
    if (user['email'] == email) return user;
  }
  return null;
}

// Update the stored list whenever XP or lessons change
static Future<void> updateAllUsersList(Map<String, dynamic> updatedUser) async {
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> usersList = await getAllUsers();
  
  // Find index of the user and replace their old data with updated stats
  int index = usersList.indexWhere((u) => u['email'] == updatedUser['email']);
  if (index != -1) {
    usersList[index] = updatedUser;
    await prefs.setString(allUsersKey, jsonEncode(usersList));
  }
}

  static Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user?["isLoggedIn"] == true;
  }

  // 5. LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final userMap = await getCurrentUser();
    if (userMap != null) {
      userMap["isLoggedIn"] = false;
      await prefs.setString(currentUserKey, jsonEncode(userMap));
    }
  }
}