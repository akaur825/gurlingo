// lib/services/app_state.dart
import '../models/user_progress.dart';
import 'local_storage_service.dart';

class AppState {
  static UserProgress? currentUser;

  // One pass mark for the whole app: 70% (7 out of 10).
  static const double passMark = 0.7;

  static bool isPassing(int score, int totalQuestions) {
    if (totalQuestions <= 0) return true;
    return score >= (totalQuestions * passMark).ceil();
  }

  /// Called once when the app starts (main.dart). Restores the saved session if there is one.
  static Future<void> init() async {
    currentUser = null;
    try {
      if (!await LocalStorageService.isLoggedIn()) return;

      final session = await LocalStorageService.getCurrentUser();
      final email = session?['email'];
      if (email is! String) {
        await LocalStorageService.logout();
        return;
      }

      final profile = await LocalStorageService.getUserProgress(email);
      if (profile == null) {
        await LocalStorageService.logout(); // saved session points to a missing account
        return;
      }

      currentUser = UserProgress.fromJson(profile);
      _expireStreakIfBroken();
    } catch (_) {
      currentUser = null;
    }
  }

  // Login: keeps the user's data in memory for the screens to read
  static void login(Map<String, dynamic> userData) {
    final user = UserProgress.fromJson(userData);
    user.email = LocalStorageService.normalizeEmail(user.email);
    currentUser = user;
    _expireStreakIfBroken();
  }

  static Future<void> logout() async {
    currentUser = null;
    await LocalStorageService.logout();
  }

  // ---------- Streak ----------

  /// Whole calendar days from [fromKey] ("yyyy-MM-dd") to [to]. Uses UTC dates so
  /// daylight-saving changes can't produce 23- or 25-hour "days".
  static int _daysBetween(String fromKey, DateTime to) {
    final from = DateTime.tryParse(fromKey);
    if (from == null) return 0;
    final a = DateTime.utc(from.year, from.month, from.day);
    final b = DateTime.utc(to.year, to.month, to.day);
    return b.difference(a).inDays;
  }

  /// If a whole day was missed, the streak shows 0 until the next quiz is finished.
  static void _expireStreakIfBroken() {
    final user = currentUser;
    if (user == null || user.lastActiveDate == null) return;
    if (_daysBetween(user.lastActiveDate!, DateTime.now()) > 1) {
      user.streakDays = 0;
    }
  }

  /// Call this when the user finishes a quiz. Adds XP, updates the streak (at most one
  /// increase per calendar day), and saves everything in one write.
  static Future<void> finishQuiz({int xpGained = 0}) async {
    final user = currentUser;
    if (user == null) return;

    user.totalXp += xpGained;

    final now = DateTime.now();
    final last = user.lastActiveDate;
    if (last == null) {
      user.streakDays = 1;
    } else {
      final gap = _daysBetween(last, now);
      if (gap == 1) {
        user.streakDays += 1; // consecutive day
      } else if (gap > 1) {
        user.streakDays = 1; // missed at least one day
      } else if (user.streakDays < 1) {
        user.streakDays = 1; // same day, make sure it shows at least 1
      }
    }
    user.lastActiveDate = dateKey(now);

    await _persist();
  }

  // ---------- Saving ----------

  static Future<void> _persist() async {
    final user = currentUser;
    if (user == null) return;
    await LocalStorageService.updateAllUsersList(user.toJson());
  }

  // Kept so older calls still work: adds XP and saves.
  static Future<void> addXpAndSave(int xpGained) async {
    if (currentUser == null) return;
    currentUser!.totalXp += xpGained;
    await _persist();
  }

  // Saves the chosen scale ("C#" or "G#")
  static Future<void> updateScale(String scaleKey) async {
    if (currentUser == null) return;
    currentUser!.preferredScale = scaleKey;
    await _persist();
  }
}
