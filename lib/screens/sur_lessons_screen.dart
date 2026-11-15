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
import '../theme/app_theme.dart';
import '../widgets/lesson_tile.dart';

class SurLessonsScreen extends StatefulWidget {
  const SurLessonsScreen({super.key});

  @override
  State<SurLessonsScreen> createState() => _SurLessonsScreenState();
}

class _SurLessonsScreenState extends State<SurLessonsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser ?? UserProgress(username: "Guest");

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("Shudh Sur Recognition"),
              const SizedBox(height: 16),

              ...List.generate(surLessons.length, (index) {
                final lesson = surLessons[index];

                final completed =
                    user.completedSurLessons.contains(lesson.id);
                final unlocked =
                    index <= user.completedSurLessons.length;

                return _lessonCard(
                  context: context,
                  lesson: lesson,
                  completed: completed,
                  unlocked: unlocked,
                );
              }),

              const SizedBox(height: 32),

              _buildSectionHeader("Vakrit Sur Recognition"),
              const SizedBox(height: 16),

              ...List.generate(vakritSurLessons.length, (index) {
                final lesson = vakritSurLessons[index];

                final completed =
                    user.completedSurLessons.contains(lesson.id);
                final unlocked =
                    (surLessons.length + index) <=
                        user.completedSurLessons.length;

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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTheme.heading(size: 26, color: AppColors.blueDeep),
    );
  }

  Widget _lessonCard({
    required BuildContext context,
    required Lesson lesson,
    required bool completed,
    required bool unlocked,
  }) {
    // Distinguish Shudh Sur lessons from Vakrit Sur lessons.
    final String lessonType =
        lesson.id.startsWith('vakrit-') ? 'vakrit' : 'sur';

    return LessonTile(
      title: lesson.title,
      completed: completed,
      unlocked: unlocked,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LessonPlayer(lesson: lesson, lessonType: lessonType),
          ),
        ).then((_) {
          if (mounted) setState(() {});
        });
      },
    );
  }
}
