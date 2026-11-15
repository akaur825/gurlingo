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
import '../theme/app_theme.dart';
import '../widgets/lesson_tile.dart';

class RaagLessonsScreen extends StatefulWidget {
  const RaagLessonsScreen({super.key});

  @override
  State<RaagLessonsScreen> createState() => _RaagLessonsScreenState();
}

class _RaagLessonsScreenState extends State<RaagLessonsScreen> {
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
              Text(
                "Raag Recognition",
                style: AppTheme.heading(size: 26, color: AppColors.blueDeep),
              ),
              const SizedBox(height: 16),
              ...List.generate(raagLessons.length, (index) {
                final lesson = raagLessons[index];
                final completed = user.completedRaagLessons.contains(lesson.id);
                final unlocked = index <= user.completedRaagLessons.length;

                return _lessonCard(
                  context: context,
                  lesson: lesson,
                  completed: completed,
                  unlocked: unlocked,
                  index: index + 1,
                );
              }),
            ],
          ),
        ),
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
    return LessonTile(
      title: lesson.title,
      completed: completed,
      unlocked: unlocked,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LessonPlayer(lesson: lesson, lessonType: 'raag'),
          ),
        ).then((_) {
          // Redraw when returning from the lesson/quiz
          if (mounted) setState(() {});
        });
      },
    );
  }
}