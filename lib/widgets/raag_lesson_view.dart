// lib/widgets/raag_lesson_view.dart
//
// The reading page for one Raag lesson, built from RaagLessonContent.

import 'package:flutter/material.dart';
import '../data/raag_lesson_content.dart';
import '../services/lesson_audio_player.dart';
import '../services/lesson_audio_service.dart';
import '../theme/app_theme.dart';
import 'lesson_widgets.dart';

class RaagLessonView extends StatelessWidget {
  final RaagLessonContent content;
  final String scale; // 'C#' or 'G#'
  final LessonAudioPlayer player;
  final VoidCallback onStartQuiz;

  const RaagLessonView({
    super.key,
    required this.content,
    required this.scale,
    required this.player,
    required this.onStartQuiz,
  });

  // The introduction lesson has no single Raag, so no recordings or facts.
  bool get _isIntro => content.audioKey.isEmpty;

  String? _safe(String Function() build) {
    try {
      return build();
    } catch (_) {
      return null;
    }
  }

  String _phrase(String p) => splitNotes(p).join(' ');

  @override
  Widget build(BuildContext context) {
    return LessonPage(
      onStartQuiz: onStartQuiz,
      children: [
        // 1. Header
        LessonHeader(
          icon: content.icon,
          title: content.name,
          subtitle: content.tagline,
          badges: _isIntro
              ? const []
              : [content.raagNumber, content.ang],
        ),

        if (!_isIntro) ...[
          // 2. At a glance
          _glanceCard(),

          // 3. Mukh Ang
          if (content.mukhAng.isNotEmpty)
            SectionCard(
              title: 'Mukh Ang',
              icon: Icons.graphic_eq,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final p in content.mukhAng)
                      NoteChip(text: _phrase(p)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  content.mukhAngNote,
                  style: const TextStyle(color: AppColors.inkSoft, height: 1.4),
                ),
              ],
            ),
        ],

        // 4. Listen for / key points
        if (content.listenFor.isNotEmpty)
          SectionCard(
            title: _isIntro ? 'Key terms' : 'Listen for',
            icon: _isIntro ? Icons.key : Icons.hearing,
            children: [
              for (final t in content.listenFor) IconBullet(text: t),
            ],
          ),

        // 5. The lesson text
        SectionCard(
          title: 'Lesson',
          icon: Icons.menu_book_outlined,
          children: [
            for (final p in content.story) LessonParagraph(p),
          ],
        ),

        // 6. Gurbani quotes
        for (final q in content.quotes) _quoteCard(q),

        if (!_isIntro) ...[
          // 7. Example Shabad
          SectionCard(
            title: 'Example Shabad',
            icon: Icons.library_music_outlined,
            children: [
              Text(
                content.exampleShabad,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ],
          ),
        ],

        // 8. Did you know?
        if (content.didYouKnow.isNotEmpty)
          SectionCard(
            title: 'Did you know?',
            icon: Icons.lightbulb_outline,
            color: AppColors.saffronSoft,
            children: [
              for (final t in content.didYouKnow) IconBullet(text: t),
            ],
          ),

        // 9. Remember
        if (content.remember.isNotEmpty)
          SectionCard(
            title: 'Remember',
            icon: Icons.checklist,
            children: [
              for (final t in content.remember)
                IconBullet(text: t, icon: Icons.check_circle_outline),
            ],
          ),
      ],
    );
  }

  // ------------------------------------------------------------ at a glance

  Widget _glanceCard() {
    final varjitAroh = content.varjitAroh;
    final varjitAvroh = content.varjitAvroh;

    return SectionCard(
      title: 'At a glance',
      icon: Icons.info_outline,
      children: [
        _fact('Thaat', content.thaat),
        _fact('Jaati', '${content.jaati} (${content.jaatiMeaning})'),
        _fact('Time', content.time),
        if (content.season != null) _fact('Season', content.season!),
        _fact('Mood', content.mood),
        const Divider(height: 28),

        // Vaadee and Samvaadee, each with a play button for the note.
        _noteRow(
          label: 'Vaadee',
          note: content.vaadee,
          name: content.vaadeeName,
        ),
        const SizedBox(height: 10),
        _noteRow(
          label: 'Samvaadee',
          note: content.samvaadee,
          name: content.samvaadeeName,
        ),
        const Divider(height: 28),

        // Aroh and Avroh, each with a play button for the recording.
        _movementRow(
          label: 'Aroh',
          phrases: content.aroh,
          note: content.arohNote,
          path: _safe(() => LessonAudioService.raagAudioByKey(
                scale,
                content.audioKey,
                avroh: false,
              )),
        ),
        const SizedBox(height: 16),
        _movementRow(
          label: 'Avroh',
          phrases: content.avroh,
          note: content.avrohNote,
          path: _safe(() => LessonAudioService.raagAudioByKey(
                scale,
                content.audioKey,
                avroh: true,
              )),
        ),
        const Divider(height: 28),

        const LabelText('Varjit notes'),
        const SizedBox(height: 6),
        Text(
          (varjitAroh.isEmpty && varjitAvroh.isEmpty)
              ? 'None. All seven notes are used.'
              : 'Aroh: ${varjitAroh.isEmpty ? 'none' : varjitAroh.join(', ')}'
                  '    Avroh: ${varjitAvroh.isEmpty ? 'none' : varjitAvroh.join(', ')}',
          style: const TextStyle(fontSize: 15, height: 1.4),
        ),
      ],
    );
  }

  Widget _fact(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelText(label),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 15, height: 1.4)),
        ],
      ),
    );
  }

  Widget _noteRow({
    required String label,
    required String note,
    required String name,
  }) {
    final path = _safe(() => LessonAudioService.surAudio(scale, note));
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelText(label),
              const SizedBox(height: 6),
              Row(
                children: [
                  NoteChip(text: note, filled: true),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(name, style: const TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
        AudioPlayButton(player: player, path: path),
      ],
    );
  }

  Widget _movementRow({
    required String label,
    required List<String> phrases,
    required String note,
    required String? path,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: LabelText(label)),
            AudioPlayButton(player: player, path: path),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in phrases) NoteChip(text: _phrase(p)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          note,
          style: const TextStyle(color: AppColors.inkSoft, height: 1.4),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------ quote

  Widget _quoteCard(RaagQuote q) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: AppColors.saffronSoft.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: const Border(
          left: BorderSide(color: AppColors.saffron, width: 5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            q.gurmukhi,
            style: const TextStyle(
              fontSize: 21,
              height: 1.7,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(q.meaning, style: const TextStyle(fontSize: 15, height: 1.5)),
          const SizedBox(height: 10),
          Text(
            '— ${q.source}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.plum,
            ),
          ),
        ],
      ),
    );
  }
}
