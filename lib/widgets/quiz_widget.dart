import 'package:flutter/material.dart';
import '../models/question.dart'; // Ensure this is the correct path

class QuizWidget extends StatefulWidget {
  // FIX: Change QuizQuestion to Question to match your quiz_data.dart
  final List<Question> questions; 
  final Function(bool, int) onComplete;

  const QuizWidget({super.key, required this.questions, required this.onComplete});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int currentQ = 0;
  int? selected;
  bool showResult = false;
  int score = 0;

  void handleCheck() {
    if (selected == null) return;
    
  
    final isCorrect = selected == widget.questions[currentQ].answer;

    if (isCorrect) score++;
    setState(() => showResult = true);
  }

  void handleNext() {
    if (currentQ + 1 >= widget.questions.length) {
      widget.onComplete(score >= (widget.questions.length * 0.7).ceil(), score);
      return;
    }
    setState(() {
      currentQ++;
      selected = null;
      showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[currentQ];
    final progress = (currentQ + (showResult ? 1 : 0)) / widget.questions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 24),
        // FIX: Changed .prompt to .questionText
        Text(q.prompt, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),

        Expanded(
          child: ListView.builder(
            // FIX: Changed .options to .answers
            itemCount: q.options.length,
            itemBuilder: (context, i) {
              bool isCorrectChoice = i == q.answer;
              
              Color borderColor = Colors.grey[300]!;
              if (showResult) {
                if (isCorrectChoice) borderColor = Colors.green;
                else if (selected == i) borderColor = Colors.red;
              } else if (selected == i) {
                borderColor = Theme.of(context).primaryColor;
              }

              return GestureDetector(
                onTap: showResult ? null : () => setState(() => selected = i),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Text(q.options[i]),
                ),
              );
            },
          ),
        ),
        
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: selected == null ? null : (showResult ? handleNext : handleCheck),
            child: Text(showResult ? "Continue" : "Check Answer"),
          ),
        ),
      ],
    );
  }
}