import '../models/user_progress.dart';
import 'local_storage_service.dart';

class AppState {
  static UserProgress? currentUser;

  // 1. App Startup Hook: Tracks dates and calculates user streaks dynamically
  static Future<void> init() async {
    bool loggedIn = await LocalStorageService.isLoggedIn();
    if (loggedIn) {
      final activeSession = await LocalStorageService.getCurrentUser();
      if (activeSession != null) {
        final profileData = await LocalStorageService.getUserProgress(activeSession['email']);
        if (profileData != null) {
          currentUser = UserProgress.fromJson(profileData); 

          // 🗓️ STREAK CALCULATION ENGINE 
          if (profileData.containsKey('lastActiveDate') && profileData['lastActiveDate'] != null) {
            DateTime lastActive = DateTime.parse(profileData['lastActiveDate']);
            DateTime now = DateTime.now();
            
            // Normalize times to midnight to calculate absolute day intervals accurately
            DateTime lastActiveMidnight = DateTime(lastActive.year, lastActive.month, lastActive.day);
            DateTime todayMidnight = DateTime(now.year, now.month, now.day);
            
            int differenceInDays = todayMidnight.difference(lastActiveMidnight).inDays;

            if (differenceInDays == 1) {
              // Consecutive daily login!
              currentUser!.streakDays += 1;
            } else if (differenceInDays > 1) {
              // Broke their streak sequence, reset back to 1
              currentUser!.streakDays = 1;
            }
            // (If difference is 0, they opened it on the same day, so streak stays exactly as it was)
          } else {
            currentUser!.streakDays = 1;
          }

          // Convert changes back to JSON and stamp the last active interaction date as right now
          final updatedData = currentUser!.toJson();
          updatedData['lastActiveDate'] = DateTime.now().toIso8601String();
          await LocalStorageService.updateAllUsersList(updatedData);
          
          return;
        }
      }
    }
    currentUser = null;
  }
  
  // 2. Login execution mapping bound scopes cleanly
  static void login(Map<String, dynamic> userData) {
    currentUser = UserProgress.fromJson(userData);
    
    if (currentUser!.email.isEmpty && userData.containsKey('email')) {
      currentUser!.email = userData['email'];
    }
  }

  // 3. Complete logout execution
  static Future<void> logout() async {
    currentUser = null;
    await LocalStorageService.logout(); 
  }

  // 4. Persistence Safe-guard: Updates total XP values and preserves streak fields during updates
  static Future<void> addXpAndSave(int xpGained) async {
    if (currentUser == null) return;
    
    currentUser!.totalXp += xpGained;

    final activeSession = await LocalStorageService.getCurrentUser();
    if (activeSession != null) {
      final updatedData = currentUser!.toJson();
      
      // Preserve tracking fields across database sync intervals
      updatedData['lastActiveDate'] = DateTime.now().toIso8601String();
      
      await LocalStorageService.updateAllUsersList(updatedData);
    }
  }

  // 5. Persistence Scale Guard: Safe-saves tuning preference
  static Future<void> updateScale(String scaleKey) async {
    if (currentUser == null) return;

    currentUser!.preferredScale = scaleKey;

    final activeSession = await LocalStorageService.getCurrentUser();
    if (activeSession != null) {
      final updatedData = currentUser!.toJson();
      updatedData['lastActiveDate'] = DateTime.now().toIso8601String();
      await LocalStorageService.updateAllUsersList(updatedData);
    }
  }
}