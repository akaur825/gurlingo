import 'package:flutter/material.dart';
import '../models/question.dart'; // Add this
import '../widgets/quiz_widget.dart';
import '../widgets/video_placeholder.dart';
import '../services/app_state.dart';
import '../models/user_progress.dart';

enum LessonPhase { video, quiz, finished }

class LessonPlayer extends StatefulWidget {
  final Lesson lesson; // Sur or Raag lesson
  final String lessonType; // "sur" or "raag"

  const LessonPlayer({
    super.key,
    required this.lesson,
    required this.lessonType,
  });

  @override
  State<LessonPlayer> createState() => _LessonPlayerState();
}

class _LessonPlayerState extends State<LessonPlayer> {
  LessonPhase phase = LessonPhase.video;
  int currentQuestion = 0;
  int score = 0;

  void _handleAnswer(bool correct) {
    if (correct) score += 1;

    if (currentQuestion + 1 < widget.lesson.questions.length) {
      setState(() {
        currentQuestion += 1;
      });
    } else {
      _finishLesson();
    }
  }

  void _finishLesson() {
    final user = AppState.currentUser ?? UserProgress(username: "Guest");
    final completedList = widget.lessonType == 'sur'
        ? user.completedSurLessons
        : user.completedRaagLessons;

    if (!completedList.contains(widget.lesson.id)) {
      completedList.add(widget.lesson.id);
    }

    user.totalXp += score * 10;

    if (widget.lessonType == 'sur') {
      user.surLevel = completedList.length;
    } else {
      user.raagLevel = completedList.length;
    }

    // Update AppState globally
    AppState.saveUser(user);

    setState(() {
      phase = LessonPhase.finished;
    });
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser ?? UserProgress(username: "Guest");

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(widget.lesson.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(user),
      ),
    );
  }

  Widget _buildBody(UserProgress user) {
    switch (phase) {
      case LessonPhase.video:
        return VideoPlaceholder(
          description: widget.lesson.videoDescription,
          onContinue: () {
            setState(() {
              phase = LessonPhase.quiz;
            });
          },
        );

      case LessonPhase.quiz:
        return QuizWidget(
          questions: widget.lesson.questions,
          onComplete: (passed, finalScore) { // Changed from onAnswer
            setState(() {
              score = finalScore;
              phase = LessonPhase.finished;
            });
          },
        );

      case LessonPhase.finished:
        final totalQuestions = widget.lesson.questions.length;
        final passed = score >= (totalQuestions * 0.7).ceil();
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                passed ? Icons.check_circle : Icons.cancel,
                size: 80,
                color: passed ? Colors.green : Colors.red,
              ),
              const SizedBox(height: 20),
              Text(
                passed ? "Excellent!" : "Keep Practicing!",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("You scored $score out of $totalQuestions"),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _goBack,
                child: const Text("Back"),
              ),
            ],
          ),
        );
    }
  }
}