import '../models/user_progress.dart';
// import 'lesson_data.dart'; // You need this to recognize the "Lesson" class

// Fix 1: Added the missing 'username' required by your UserProgress class
UserProgress user = UserProgress(
  username: "Student", 
  totalXp: 90,
  streakDays: 1,
  completedSurLessons: ['1', '2'],
  completedRaagLessons: ['1'],
);