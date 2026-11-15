// lib/screens/lesson_player_screen.dart
//
// Plays one lesson: read the lesson text, take its quiz, see the result.
// The lesson text comes from raag_lesson_content.dart / sur_lesson_content.dart
// and the quiz from quiz_data.dart, both looked up by lesson id.

import 'package:flutter/material.dart';
import '../widgets/parchment_background.dart';
import '../data/quiz_data.dart';
import '../data/raag_lesson_content.dart';
import '../data/sur_lesson_content.dart';
import '../models/question.dart';
import '../services/app_state.dart';
import '../services/lesson_audio_player.dart';
import '../theme/app_theme.dart';
import '../widgets/lesson_widgets.dart';
import '../widgets/quiz_widget.dart';
import '../widgets/raag_lesson_view.dart';
import '../widgets/sur_lesson_view.dart';

enum LessonPhase { lesson, quiz, finished }

class LessonPlayer extends StatefulWidget {
  final Lesson lesson;
  final String lessonType; // "sur", "vakrit" or "raag"

  const LessonPlayer({
    super.key,
    required this.lesson,
    required this.lessonType,
  });

  @override
  State<LessonPlayer> createState() => _LessonPlayerState();
}

class _LessonPlayerState extends State<LessonPlayer> {
  LessonPhase phase = LessonPhase.lesson;
  int score = 0;
  bool passed = false; // set once when the quiz ends (pass mark: AppState.passMark)
  int attempt = 0; // bumped on retry so the quiz starts fresh

  // One audio player for the whole lesson page; disposing it stops all sound.
  final LessonAudioPlayer _player = LessonAudioPlayer();

  late final List<Question> quizQuestions;
  late final String scale;

  bool get _isRaag => widget.lessonType.toLowerCase() == 'raag';

  @override
  void initState() {
    super.initState();
    scale = AppState.currentUser?.preferredScale ?? 'C#';
    quizQuestions = QuizData.getQuiz(widget.lesson.id, scale: scale);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _startQuiz() {
    _player.stop();
    setState(() => phase = LessonPhase.quiz);
  }

  void _retryQuiz() {
    setState(() {
      attempt++;
      score = 0;
      passed = false;
      phase = LessonPhase.quiz;
    });
  }

  void _finishLesson(bool quizPassed, int finalScore) async {
    final user = AppState.currentUser;
    int xpGained = 0;

    if (user != null && quizPassed) {
      // Raag lessons and Sur lessons keep separate completion lists. Vakrit
      // lessons belong to the Sur list (sur_lessons_screen.dart reads it).
      final completedList =
          _isRaag ? user.completedRaagLessons : user.completedSurLessons;

      if (!completedList.contains(widget.lesson.id)) {
        completedList.add(widget.lesson.id);
        xpGained = finalScore * 10; // XP only the first time a lesson is passed
      }
    }

    // Save XP, streak and completed lessons. A saving problem must never trap the user here.
    try {
      await AppState.finishQuiz(xpGained: xpGained);
    } catch (e) {
      debugPrint('Could not save progress: $e');
    }

    if (!mounted) return;
    setState(() {
      score = finalScore;
      passed = quizPassed;
      phase = LessonPhase.finished;
    });
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PatternScaffold(
      appBar: AppBar(
        title: Text(
          widget.lesson.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: phase == LessonPhase.lesson
          ? _buildBody() // the lesson page manages its own padding and bottom bar
          : Padding(
              padding: const EdgeInsets.all(16),
              child: _buildBody(),
            ),
    );
  }

  Widget _buildBody() {
    switch (phase) {
      case LessonPhase.lesson:
        return _buildLesson();

      case LessonPhase.quiz:
        if (quizQuestions.isEmpty) {
          return Center(
            child: Text(
              'No quiz questions found for ${widget.lesson.title}.',
              style: const TextStyle(fontSize: 16, color: AppColors.bad),
            ),
          );
        }
        return QuizWidget(
          key: ValueKey(attempt),
          questions: quizQuestions,
          onComplete: (quizPassed, finalScore) {
            _finishLesson(quizPassed, finalScore);
          },
        );

      case LessonPhase.finished:
        return _buildResult();
    }
  }

  Widget _buildLesson() {
    if (_isRaag) {
      final content = raagLessonContents[widget.lesson.id];
      if (content != null) {
        return RaagLessonView(
          content: content,
          scale: scale,
          player: _player,
          onStartQuiz: _startQuiz,
        );
      }
    } else {
      final content = SurLessonData.getLesson(widget.lesson.id);
      if (content != null) {
        return SurLessonView(
          content: content,
          scale: scale,
          player: _player,
          onStartQuiz: _startQuiz,
        );
      }
    }

    // Content missing: still let the learner reach the quiz.
    return LessonPage(
      onStartQuiz: _startQuiz,
      children: [
        LessonHeader(
          icon: Icons.music_note,
          title: widget.lesson.title,
          subtitle: widget.lesson.description,
        ),
      ],
    );
  }

  Widget _buildResult() {
    final totalQuestions = quizQuestions.length;

    final tint = passed ? AppColors.good : AppColors.bad;

    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.card(radius: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: (passed ? AppColors.goodSoft : AppColors.badSoft),
                child: Icon(
                  passed ? Icons.check_rounded : Icons.close_rounded,
                  size: 52,
                  color: tint,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                passed ? "Excellent!" : "Keep Practicing!",
                textAlign: TextAlign.center,
                style: AppTheme.heading(size: 28, color: AppColors.blueDeep),
              ),
              const SizedBox(height: 10),
              Text(
                "You scored $score out of $totalQuestions",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, color: AppColors.inkSoft),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _retryQuiz,
                  child: const Text("Retry Quiz"),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _goBack,
                  child: const Text("Back to Lessons"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
