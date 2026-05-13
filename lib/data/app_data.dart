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

// final List<Lesson> surLessons = [
//   Lesson(id: '1', title: 'Sa — The Foundation'),
//   Lesson(id: '2', title: 'Sa & Re — First Steps'),
//   Lesson(id: '3', title: 'Sa Re Ga — Building Up'),
//   Lesson(id: '4', title: 'Adding Ma — The Middle'),
// ];

// final List<Lesson> raagLessons = [
//   Lesson(id: '1', title: 'What is a Raag?'),
//   Lesson(id: '2', title: 'Raag Components'),
//   Lesson(id: '3', title: 'Raag Sri'),
//   Lesson(id: '4', title: 'Raag Aasa'),
// ];