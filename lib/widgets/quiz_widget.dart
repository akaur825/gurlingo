import 'package:flutter/material.dart';
import '../models/question.dart'; 

class QuizWidget extends StatefulWidget {
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

  // Helper method to simulate playing audio safely
  void _playAudio(String path) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🔊 Playing audio: $path"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

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
    const Color brandBlue = Color(0xFF005099);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress Indicator
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(brandBlue),
        ),
        const SizedBox(height: 24),
        
        // Question Prompt Text
        Text(
          q.prompt, 
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // 🎧 TYPE 2: QUESTION HAS AUDIO ATTACHED
        if ((q.type == "audio_question" || q.type == "audio") && q.audioPath != null) ...[
          Card(
            color: brandBlue.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: brandBlue,
                child: Icon(Icons.volume_up, color: Colors.white),
              ),
              title: const Text("Listen to the musical sample", style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandBlue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _playAudio(q.audioPath!),
                icon: const Icon(Icons.play_arrow, size: 18),
                label: const Text("Play"),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Answer Layout Space
        Expanded(
          child: ListView.builder(
            itemCount: q.options.length,
            itemBuilder: (context, i) {
              bool isCorrectChoice = i == q.answer;
              
              Color borderColor = Colors.grey[300]!;
              Color cardBgColor = Colors.white;

              if (showResult) {
                if (isCorrectChoice) {
                  borderColor = Colors.green;
                  cardBgColor = Colors.green.shade50;
                } else if (selected == i) {
                  borderColor = Colors.red;
                  cardBgColor = Colors.red.shade50;
                }
              } else if (selected == i) {
                borderColor = brandBlue;
                cardBgColor = brandBlue.withOpacity(0.05);
              }

              return GestureDetector(
                onTap: showResult ? null : () => setState(() => selected = i),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          q.options[i],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      
                      // 🎧 TYPE 3: OPTION SELECTIONS ARE AUDIO CLIPS
                      if (q.type == "audio_options" && q.optionAudioPaths != null && i < q.optionAudioPaths!.length)
                        IconButton(
                          icon: const Icon(Icons.play_circle_fill, color: brandBlue, size: 30),
                          onPressed: () => _playAudio(q.optionAudioPaths![i]),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        // Lower Action Button
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: brandBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 2,
              ),
              onPressed: selected == null ? null : (showResult ? handleNext : handleCheck),
              child: Text(
                showResult ? "Continue" : "Check Answer",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}