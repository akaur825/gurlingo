import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/app_state.dart';
import '../services/lesson_audio_player.dart';
import '../theme/app_theme.dart';
import 'lesson_widgets.dart';

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

  // One player for the whole quiz (see lesson_audio_player.dart). The play
  // buttons toggle play / stop, the same as on the lesson page.
  final LessonAudioPlayer _audioPlayer = LessonAudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose(); // stops sound when leaving the quiz
    super.dispose();
  }

  void handleCheck() {
    if (selected == null) return;
    _audioPlayer.stop(); // don't let a clip keep playing under the result
    final isCorrect = selected == widget.questions[currentQ].answer;
    if (isCorrect) score++;
    setState(() => showResult = true);
  }

  void handleNext() {
    _audioPlayer.stop(); // cut off any audio before the next question
    if (currentQ + 1 >= widget.questions.length) {
      widget.onComplete(AppState.isPassing(score, widget.questions.length), score);
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
    final total = widget.questions.length;
    final progress = (currentQ + (showResult ? 1 : 0)) / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(value: progress, minHeight: 10),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${currentQ + 1}/$total',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.wood,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Everything else scrolls, so long questions and four audio options
        // fit on small screens too. The action button stays pinned below.
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 8),
            children: [
              Text(q.prompt, style: AppTheme.heading(size: 22)),
              const SizedBox(height: 16),

              if ((q.type == "audio_question" || q.type == "audio") &&
                  q.audioPath != null) ...[
                _questionAudioCard(q.audioPath!),
                const SizedBox(height: 16),
              ],

              for (var i = 0; i < q.options.length; i++) _optionTile(q, i),
            ],
          ),
        ),

        // Lower action button
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selected == null ? null : (showResult ? handleNext : handleCheck),
              child: Text(showResult ? "Continue" : "Check Answer"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _questionAudioCard(String path) {
    return AnimatedBuilder(
      animation: _audioPlayer,
      builder: (context, _) {
        final playing = _audioPlayer.playingPath == path;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFC2D1E0)),
          ),
          child: Row(
            children: [
              AudioPlayButton(player: _audioPlayer, path: path, size: 52),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  playing ? "Playing… tap to stop" : "Tap to listen",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blueDeep,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _optionTile(Question q, int i) {
    final isCorrectChoice = i == q.answer;

    Color borderColor = const Color(0xFFD2C2A8);
    Color textColor = AppColors.ink;
    Color bg = AppColors.cream;

    if (showResult) {
      if (isCorrectChoice) {
        borderColor = AppColors.good;
        bg = AppColors.goodSoft;
      } else if (selected == i) {
        borderColor = AppColors.bad;
        bg = AppColors.badSoft;
      }
    } else if (selected == i) {
      borderColor = AppColors.blue;
      textColor = AppColors.blue;
      bg = const Color(0xFFE8EEF5);
    }

    final hasAudio = q.type == "audio_options" &&
        q.optionAudioPaths != null &&
        i < q.optionAudioPaths!.length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: showResult ? null : () => setState(() => selected = i),
          child: Ink(
            padding: EdgeInsets.fromLTRB(16, hasAudio ? 10 : 16, hasAudio ? 10 : 16, hasAudio ? 10 : 16),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: selected == i ? 2.5 : (showResult && isCorrectChoice ? 2 : 1.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    q.options[i],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor),
                  ),
                ),
                if (hasAudio)
                  AudioPlayButton(
                    player: _audioPlayer,
                    path: q.optionAudioPaths![i],
                    size: 44,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
