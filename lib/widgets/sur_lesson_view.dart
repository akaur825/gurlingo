// lib/widgets/sur_lesson_view.dart
//
// The reading page for one Sur or Vakrit Sur lesson, built from
// SurLessonContent: written text, a Practice section with one card per
// Sargam, the singing instructions, then the Start Quiz button.

import 'package:flutter/material.dart';
import '../data/sur_lesson_content.dart';
import '../services/lesson_audio_player.dart';
import '../services/lesson_audio_service.dart';
import '../theme/app_theme.dart';
import 'lesson_widgets.dart';

class SurLessonView extends StatelessWidget {
  final SurLessonContent content;
  final String scale; // 'C#' or 'G#'
  final LessonAudioPlayer player;
  final VoidCallback onStartQuiz;

  const SurLessonView({
    super.key,
    required this.content,
    required this.scale,
    required this.player,
    required this.onStartQuiz,
  });

  // Written content split into paragraphs on blank lines.
  List<String> get _paragraphs => content.writtenContent
      .trim()
      .split(RegExp(r'\r?\n\s*\r?\n'))
      .map((p) => p.trim())
      .where((p) => p.isNotEmpty)
      .toList();

  // Practice cards go just before the singing instructions. Lessons without
  // them (the introduction) put practice before the closing greeting.
  int _practiceIndex(List<String> paragraphs) {
    final i = paragraphs.indexOf(SurLessonData.singingInstructions);
    if (i != -1) return i;
    final last = paragraphs.lastIndexOf(SurLessonData.greeting);
    return last > 0 ? last : paragraphs.length;
  }

  @override
  Widget build(BuildContext context) {
    final paragraphs = _paragraphs;
    final at = _practiceIndex(paragraphs);

    return LessonPage(
      onStartQuiz: onStartQuiz,
      children: [
        LessonHeader(
          icon: Icons.music_note,
          title: content.title,
          badges: [content.surName],
        ),

        // Body text before the practice section.
        SectionCard(
          children: [
            for (var i = 0; i < at; i++) LessonParagraph(paragraphs[i]),
          ],
        ),

        _practiceCard(),

        // Singing instructions, then the closing greeting.
        if (at < paragraphs.length)
          SectionCard(
            children: [
              for (var i = at; i < paragraphs.length; i++)
                paragraphs[i] == SurLessonData.singingInstructions
                    ? _instructions(paragraphs[i])
                    : LessonParagraph(paragraphs[i]),
            ],
          ),
      ],
    );
  }

  Widget _instructions(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.saffronSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.record_voice_over, color: kBrandBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 15, height: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _practiceCard() {
    return SectionCard(
      title: 'Practice',
      icon: Icons.headphones,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: kBrandBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Scale: $scale',
            style: const TextStyle(
              color: kBrandBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 14),
        for (final seq in content.practiceSequences) _sequenceCard(seq),
      ],
    );
  }

  Widget _sequenceCard(String sequence) {
    String? path;
    try {
      path = LessonAudioService.sargamAudio(scale, sequence);
    } catch (_) {
      path = null; // recording missing: show the Sargam, disable the button
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
      decoration: BoxDecoration(
        color: AppColors.parchment,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              sequence.replaceAll('’', "'"),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
          ),
          AudioPlayButton(player: player, path: path, size: 44),
        ],
      ),
    );
  }
}
