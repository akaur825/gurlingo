//It displays a vertical, scrollable list of lessons 
//dedicated to training the user's ear for musical 
//notes (Sur). It handles locking/unlocking lessons 
//sequentially. Unlocked ones are orange, completed 
//ones are green, and locked ones are grey.
import 'package:flutter/material.dart';
import '../services/app_state.dart';
import 'lesson_player_screen.dart';
import '../data/lesson_data.dart';
import '../models/user_progress.dart';
import '../models/question.dart';

class SurLessonsScreen extends StatefulWidget {
  const SurLessonsScreen({super.key});

  @override
  State<SurLessonsScreen> createState() => _SurLessonsScreenState();
}

class _SurLessonsScreenState extends State<SurLessonsScreen> {
  @override
  Widget build(BuildContext context) {
    // Pulls fresh user progress every time the widget builds or rebuilds
    final user = AppState.currentUser ?? UserProgress(username: "Guest");

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Section 1: Sur Recognition ---
              _buildSectionHeader("Shudh Sur Recognition"),
              const SizedBox(height: 16),
              ...List.generate(surLessons.length, (index) {
                final lesson = surLessons[index];

                bool completed = user.completedSurLessons.contains(lesson.id);
                // Unlocks sequentially for the first list
                bool unlocked = index <= user.completedSurLessons.length;

                return _lessonCard(
                  context: context,
                  lesson: lesson,
                  completed: completed,
                  unlocked: unlocked,
                );
              }),

              const SizedBox(height: 32), // Clear spacing between sections

              // --- Section 2: Vakrit Sur Recognition ---
              _buildSectionHeader("Vakrit Sur Recognition"),
              const SizedBox(height: 16),
              ...List.generate(vakritSurLessons.length, (index) {
                final lesson = vakritSurLessons[index];

                bool completed = user.completedSurLessons.contains(lesson.id);
                // Unlocks sequentially only AFTER all standard surLessons are completed
                bool unlocked = (surLessons.length + index) <= user.completedSurLessons.length;

                return _lessonCard(
                  context: context,
                  lesson: lesson,
                  completed: completed,
                  unlocked: unlocked,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Section Header Helper to keep UI text clean and uniform
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _lessonCard({
    required BuildContext context,
    required Lesson lesson,
    required bool completed,
    required bool unlocked,
  }) {
    Color bgColor;
    IconData icon;

    if (completed) {
      bgColor = Colors.green.shade100;
      icon = Icons.check;
    } else if (unlocked) {
      bgColor = Colors.orange.shade100;
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
                    lessonType: 'sur',
                  ),
                ),
              ).then((_) {
                // Refresh progress state when returning to this screen
                setState(() {});
              });
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
              child: Icon(
                icon,
                color: unlocked || completed 
                    ? const Color(0xFF005099) 
                    : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(lesson.title)),
          ],
        ),
      ),
    );
  }
}