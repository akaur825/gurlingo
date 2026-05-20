//It works exactly like the Sur screen, 
//but it is for Raag lessons. It shows a
// list of lessons where unlocked items 
//are colored blue.
import 'package:flutter/material.dart';
import '../services/app_state.dart';
import 'lesson_player_screen.dart';
import '../data/lesson_data.dart';
import '../models/user_progress.dart';
import '../models/question.dart';

class RaagLessonsScreen extends StatelessWidget {
  const RaagLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser ?? UserProgress(username: "Guest");

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text("Raag Lessons"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: raagLessons.length,
        itemBuilder: (context, index) {
          final lesson = raagLessons[index];

          bool completed = user.completedRaagLessons.contains(lesson.id);
          bool unlocked = index <= user.completedRaagLessons.length;

          return _lessonCard(
            context: context,
            lesson: lesson,
            completed: completed,
            unlocked: unlocked,
            index: index + 1,
          );
        },
      ),
    );
  }

  Widget _lessonCard({
    required BuildContext context,
    required Lesson lesson,
    required bool completed,
    required bool unlocked,
    required int index,
  }) {
    Color bgColor;
    IconData icon;

    if (completed) {
      bgColor = Colors.green.shade100;
      icon = Icons.check;
    } else if (unlocked) {
      bgColor = Colors.blue.shade100;
      icon = Icons.play_arrow;
    } else {
      bgColor = Colors.grey.shade200;
      icon = Icons.lock;
    }

    return GestureDetector(
      onTap: unlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonPlayer(
                    lesson: lesson,
                    lessonType: 'raag',
                  ),
                ),
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(icon),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(lesson.title)),
          ],
        ),
      ),
    );
  }
}