import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/question.dart';
import '../data/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  final String quizType;
  final int level;

  const QuizScreen({super.key, required this.quizType, required this.level});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> questions;
  int currentIndex = 0;
  int score = 0;
  bool answered = false;
  int? selectedIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    questions = QuizData.getQuestions(widget.quizType, widget.level);
  }

  void handleAnswer(int index) {
    if (answered) return;
    setState(() {
      answered = true;
      selectedIndex = index;
      if (index == questions[currentIndex].answer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        answered = false;
        selectedIndex = null;
      });
    } else {
      // Show Results (Unity's quizEndPanel logic)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Quiz Finished!"),
          content: Text("You scored ${(score / questions.length * 100).toStringAsFixed(0)}%"),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')), 
              child: const Text("Finish"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];
    double progress = (currentIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(title: Text("${widget.quizType} Level ${widget.level}")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 20),
            Text(q.prompt, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Audio Question Play Button
            if (q.type == "audio")
              IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 60, color: Colors.blue),
                onPressed: () => _audioPlayer.play(AssetSource(q.audioPath!)),
              ),
            const SizedBox(height: 20),
            // Answer Options
            Expanded(
              child: ListView.builder(
                itemCount: q.options.length,
                itemBuilder: (context, index) {
                  Color btnColor = Colors.white;
                  if (answered) {
                    if (index == q.answer) btnColor = Colors.green.shade200;
                    else if (index == selectedIndex) btnColor = Colors.orange.shade200;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: btnColor),
                      onPressed: () => handleAnswer(index),
                      child: Row(
                        children: [
                          Expanded(child: Text(q.options[index])),
                          if (q.type == "audio")
                            IconButton(
                              icon: const Icon(Icons.volume_up),
                              onPressed: () => _audioPlayer.play(AssetSource(q.audioPath![index])),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (answered)
              ElevatedButton(
                onPressed: nextQuestion,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: Text(currentIndex == questions.length - 1 ? "Finish" : "Next"),
              ),
          ],
        ),
      ),
    );
  }
}