import '../models/user_progress.dart';
import 'local_storage_service.dart';

class AppState {
  static UserProgress? currentUser;

  // 1. App Startup Hook: Run this in main.dart before runApp()
  static Future<void> init() async {
    bool loggedIn = await LocalStorageService.isLoggedIn();
    if (loggedIn) {
      final activeSession = await LocalStorageService.getCurrentUser();
      if (activeSession != null) {
        // Load their actual profile stats from the local list
        final profileData = await LocalStorageService.getUserProgress(activeSession['email']);
        if (profileData != null) {
          currentUser = UserProgress.fromJson(profileData); 
          return;
        }
      }
    }
    currentUser = null;
  }

  // 2. FIXED: Uses the model factory method directly to pull historical parameters cleanly
  static void login(Map<String, dynamic> userData) {
    currentUser = UserProgress.fromJson(userData);
    
    // Explicitly fallback bind the current email scope if missing from registration passes
    if (currentUser!.email.isEmpty && userData.containsKey('email')) {
      currentUser!.email = userData['email'];
    }
  }

  // 3. Complete logout execution
  static Future<void> logout() async {
    currentUser = null;
    await LocalStorageService.logout(); 
  }

  // 4. Persistence Safe-guard: Call this when a user finishes a lesson!
  static Future<void> addXpAndSave(int xpGained) async {
    if (currentUser == null) return;
    
    // Update local variable state
    currentUser!.totalXp += xpGained;

    // Get active email to locate them in local storage
    final activeSession = await LocalStorageService.getCurrentUser();
    if (activeSession != null) {
      // Create data map to push back down into storage list using model mappings
      final updatedData = currentUser!.toJson();
      
      await LocalStorageService.updateAllUsersList(updatedData);
    }
  }
}