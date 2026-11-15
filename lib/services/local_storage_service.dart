// lib/services/local_storage_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String allUsersKey = "all_users";
  static const String currentUserKey = "current_user";

  // Fields that belong to the login system only. They are never handed to the app screens.
  static const List<String> _secretFields = ['password', 'passwordHash', 'salt'];

  /// "  Avneet@Mail.com " and "avneet@mail.com" are the same account.
  static String normalizeEmail(String email) => email.trim().toLowerCase();

  static String _newSalt() {
    final rng = Random.secure();
    final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
    return base64UrlEncode(bytes);
  }

  static String _hashPassword(String password, String salt) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }

  static Map<String, dynamic> _withoutSecrets(Map<String, dynamic> user) {
    final copy = Map<String, dynamic>.from(user);
    for (final field in _secretFields) {
      copy.remove(field);
    }
    return copy;
  }

  // 1. SAVE NEW USER (Sign Up)
  static Future<bool> saveUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersList = await getAllUsers();
    final cleanEmail = normalizeEmail(email);

    final emailExists = usersList.any(
      (u) => normalizeEmail((u['email'] ?? '').toString()) == cleanEmail,
    );
    if (emailExists) {
      return false; // Registration failed because the account exists
    }

    final salt = _newSalt();
    final newUser = <String, dynamic>{
      "username": name,
      "email": cleanEmail,
      "passwordHash": _hashPassword(password, salt),
      "salt": salt,
      "totalXp": 0,
      "streakDays": 0, // the first finished quiz starts the streak at 1
      "preferredScale": "C#",
      "completedSurLessons": <String>[],
      "completedRaagLessons": <String>[],
    };

    usersList.add(newUser);
    await prefs.setString(allUsersKey, jsonEncode(usersList));
    await setCurrentUser(name, cleanEmail);
    return true;
  }

  // 2. HELPER: Get all created users (includes the login fields, internal use only)
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(allUsersKey);
    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  // 3. VALIDATE LOGIN
  static Future<Map<String, dynamic>?> authenticateUser(String email, String password) async {
    final cleanEmail = normalizeEmail(email);
    final users = await getAllUsers();

    for (int i = 0; i < users.length; i++) {
      final user = users[i];
      if (normalizeEmail((user['email'] ?? '').toString()) != cleanEmail) continue;

      bool ok = false;
      final salt = user['salt'];
      final hash = user['passwordHash'];

      if (salt is String && hash is String) {
        ok = _hashPassword(password, salt) == hash;
      } else if (user['password'] is String) {
        // Account made before hashing existed: check once, then upgrade it in place.
        ok = user['password'] == password;
        if (ok) {
          final newSalt = _newSalt();
          user['salt'] = newSalt;
          user['passwordHash'] = _hashPassword(password, newSalt);
          user.remove('password');
          users[i] = user;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(allUsersKey, jsonEncode(users));
        }
      }

      if (!ok) return null;

      final username = (user['username'] ?? user['name'] ?? 'User').toString();
      await setCurrentUser(username, cleanEmail);
      return _withoutSecrets(user);
    }
    return null;
  }

  // 4. SESSION MANAGEMENT
  static Future<void> setCurrentUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    final activeUser = {
      "username": name,
      "email": normalizeEmail(email),
      "isLoggedIn": true,
    };
    await prefs.setString(currentUserKey, jsonEncode(activeUser));
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(currentUserKey);
    if (data == null) return null;
    try {
      return Map<String, dynamic>.from(jsonDecode(data));
    } catch (_) {
      return null; // damaged session data: treat as logged out
    }
  }

  // Fetch a saved progress profile by email (without login fields)
  static Future<Map<String, dynamic>?> getUserProgress(String email) async {
    final cleanEmail = normalizeEmail(email);
    final users = await getAllUsers();
    for (final user in users) {
      if (normalizeEmail((user['email'] ?? '').toString()) == cleanEmail) {
        return _withoutSecrets(user);
      }
    }
    return null;
  }

  // Save changed progress (XP, scale, lessons, streak) WITHOUT touching the login fields.
  // This is the fix for accounts losing their password after the first save.
  static Future<void> updateAllUsersList(Map<String, dynamic> updatedUser) async {
    final prefs = await SharedPreferences.getInstance();
    final usersList = await getAllUsers();
    final cleanEmail = normalizeEmail((updatedUser['email'] ?? '').toString());

    final index = usersList.indexWhere(
      (u) => normalizeEmail((u['email'] ?? '').toString()) == cleanEmail,
    );
    if (index == -1) return;

    final merged = Map<String, dynamic>.from(usersList[index]); // keeps passwordHash + salt
    updatedUser.forEach((key, value) {
      if (!_secretFields.contains(key)) {
        merged[key] = value;
      }
    });
    merged['email'] = cleanEmail;

    usersList[index] = merged;
    await prefs.setString(allUsersKey, jsonEncode(usersList));
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
