import '../models/user_progress.dart';
import 'local_storage_service.dart'; // Import this!

class AppState {
  static UserProgress? currentUser;

  static void login(String username) {
    currentUser = UserProgress(
      username: username,
      totalXp: 0,
      streakDays: 1,
      completedSurLessons: [],
      completedRaagLessons: [],
    );
  }

  // Change to Future<void> and add "await"
  static Future<void> logout() async {
    currentUser = null;
    // This tells the local storage to also say "logged out"
    await LocalStorageService.logout(); 
  }

  static void saveUser(UserProgress user) {
    currentUser = user;
  }
}