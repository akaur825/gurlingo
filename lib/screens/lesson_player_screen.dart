import '../data/quiz_data.dart';
import 'package:flutter/material.dart';
import '../models/question.dart'; 
import '../widgets/quiz_widget.dart';
import '../widgets/video_placeholder.dart';
import '../services/app_state.dart';

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
  List<Question> quizQuestions = []; // 👈 1. Create a stable storage list

  @override
  void initState() {
    super.initState();
    // 👈 2. Load the questions ONCE right when the screen opens
    final String formattedType = widget.lessonType.toLowerCase() == 'sur' ? 'Sur' : 'Raag';
    final int lessonLevel = int.tryParse(widget.lesson.id.split('-').last) ?? 1;
    quizQuestions = QuizData.getQuestions(formattedType, lessonLevel);
  }

  void _finishLesson(int finalScore) async {
    setState(() {
      score = finalScore;
    });

    final totalQuestions = quizQuestions.length; // 👈 Uses the stable list length
    final passed = totalQuestions > 0 ? finalScore >= (totalQuestions * 0.75).ceil() : true;

    final user = AppState.currentUser;
    
    if (user != null && passed) {
      final completedList = widget.lessonType == 'sur'
          ? user.completedSurLessons
          : user.completedRaagLessons;

      if (!completedList.contains(widget.lesson.id)) {
        completedList.add(widget.lesson.id);
      }

      if (widget.lessonType == 'sur') {
        user.completedSurLessons = completedList;
      } else {
        user.completedRaagLessons = completedList;
      }

      int xpGained = finalScore * 10;
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
        // 👈 3. If no questions loaded in initState, show error safely
        if (quizQuestions.isEmpty) {
          final String formattedType = widget.lessonType.toLowerCase() == 'sur' ? 'Sur' : 'Raag';
          final int lessonLevel = int.tryParse(widget.lesson.id.split('-').last) ?? 1;
          return Center(
            child: Text(
              "No quiz questions found for $formattedType Level $lessonLevel!",
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }

        // 👈 4. Passes the perfectly preserved list down
        return QuizWidget(
          questions: quizQuestions,
          onComplete: (quizPassed, finalScore) { 
            _finishLesson(finalScore);
          },
        );

      case LessonPhase.finished:
        final totalQuestions = quizQuestions.length;
        final passed = totalQuestions > 0 ? score >= (totalQuestions * 0.75).ceil() : true;
        
        return Column(
          children: [
            const Spacer(),
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
            Text("You scored $score out of $totalQuestions", style: const TextStyle(fontSize: 16)),
            const Spacer(),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: SizedBox(
                width: double.infinity, 
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005099), 
                    foregroundColor: Colors.white,            
                    padding: const EdgeInsets.symmetric(vertical: 16), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18), 
                    ),
                    elevation: 2,
                  ),
                  onPressed: _goBack,
                  child: const Text(
                    "Back to Lessons",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}