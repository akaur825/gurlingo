//When a user clicks on any unlocked lesson from 
//either the Sur or Raag list, they are sent here. 
//This screen acts like a slideshow that moves 
//through 3 phases:
//     Phase 1 (Video): It shows a video player/placeholder
//     explaining the musical concept.
//     Phase 2 (Quiz): It automatically swaps out the video
//     and loads a quiz related to that specific lesson.
//     Phase 3 (Finished): It shows a completion screen 
//     with a green checkmark or red "X", tells you your 
//     score, updates your user profile with XP points, 
//     saves it to the phone's memory, and gives you a 
//     "Back" button to return to the list.
import 'package:flutter/material.dart';
import '../models/question.dart'; 
import '../widgets/quiz_widget.dart';
import '../widgets/video_placeholder.dart';
import '../services/app_state.dart';
import '../models/user_progress.dart';

enum LessonPhase { video, quiz, finished }

class LessonPlayer extends StatefulWidget {
  final Lesson lesson; 
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
  int score = 0;

  // FIX: Unified lesson completion logic that pushes to permanent storage layers
  void _finishLesson(int finalScore) async {
    setState(() {
      score = finalScore;
    });

    final user = AppState.currentUser;
    if (user != null) {
      final completedList = widget.lessonType == 'sur'
          ? user.completedSurLessons
          : user.completedRaagLessons;

      // Track completion list strings securely
      if (!completedList.contains(widget.lesson.id)) {
        completedList.add(widget.lesson.id);
      }

      if (widget.lessonType == 'sur') {
        user.completedSurLessons = completedList;
      } else {
        user.completedRaagLessons = completedList;
      }

      // Calculate XP added to profile mapping
      int xpGained = finalScore * 10;

      // FIX: Updates local runtime values AND saves data down to SharedPreferences
      await AppState.addXpAndSave(xpGained);
    }

    if (mounted) {
      setState(() {
        phase = LessonPhase.finished;
      });
    }
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
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
          onComplete: (passed, finalScore) { 
            _finishLesson(finalScore);
          },
        );

      case LessonPhase.finished:
        final totalQuestions = widget.lesson.questions.length;
        final passed = totalQuestions > 0 ? score >= (totalQuestions * 0.7).ceil() : true;
        
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