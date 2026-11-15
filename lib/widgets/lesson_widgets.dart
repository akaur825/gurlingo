// lib/widgets/lesson_widgets.dart
//
// Small building blocks shared by the Raag and Sur lesson pages.

import 'package:flutter/material.dart';
import '../services/lesson_audio_player.dart';
import '../theme/app_theme.dart';

const Color kBrandBlue = AppColors.blue;
const String kGreeting = 'Waheguru Ji Ka Khalsa, Waheguru Ji Ki Fateh.';

/// Round play / stop button for one audio clip. [path] may be null when the
/// recording could not be found; the button is then disabled.
class AudioPlayButton extends StatelessWidget {
  final LessonAudioPlayer player;
  final String? path;
  final double size;

  const AudioPlayButton({
    super.key,
    required this.player,
    required this.path,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: player,
      builder: (context, _) {
        final playing = path != null && player.playingPath == path;
        return SizedBox(
          width: size,
          height: size,
          child: Material(
            color: path == null
                ? AppColors.border
                : (playing ? AppColors.saffron : kBrandBlue),
            elevation: path == null ? 0 : 2,
            shadowColor: AppColors.wood,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: path == null ? null : () => player.toggle(path!),
              child: Icon(
                playing ? Icons.stop_rounded : Icons.play_arrow_rounded,
                color: playing ? AppColors.blueDeep : Colors.white,
                size: size * 0.62,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// White rounded card with an optional title.
class SectionCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final List<Widget> children;
  final Color? color;

  const SectionCard({
    super.key,
    this.title,
    this.icon,
    required this.children,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: AppTheme.card(color: color, radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: AppColors.plum, size: 22),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(title!, style: AppTheme.heading(size: 19)),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          ...children,
        ],
      ),
    );
  }
}

/// Pill that shows a note phrase such as "S R G" or "GPDP".
class NoteChip extends StatelessWidget {
  final String text;
  final bool filled;

  const NoteChip({super.key, required this.text, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? kBrandBlue : kBrandBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: filled
            ? null
            : Border.all(color: kBrandBlue.withValues(alpha: 0.18)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          color: filled ? Colors.white : kBrandBlue,
        ),
      ),
    );
  }
}

/// Small grey label above a value.
class LabelText extends StatelessWidget {
  final String text;
  const LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: AppColors.wood,
      ),
    );
  }
}

/// One paragraph of lesson text. The Waheguru greeting is centred and bold.
class LessonParagraph extends StatelessWidget {
  final String text;
  const LessonParagraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final isGreeting = text.trim() == kGreeting;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        textAlign: isGreeting ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          fontWeight: isGreeting ? FontWeight.bold : FontWeight.w500,
          color: isGreeting ? AppColors.plum : AppColors.ink,
        ),
      ),
    );
  }
}

/// Bulleted line with a leading icon.
class IconBullet extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconBullet({
    super.key,
    required this.text,
    this.icon = Icons.circle,
  });

  @override
  Widget build(BuildContext context) {
    final small = icon == Icons.circle;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: small ? 7 : 3, right: 10),
            child: Icon(icon, size: small ? 7 : 18, color: AppColors.saffron),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Scrollable lesson page with a "Start Quiz" button pinned to the bottom.
class LessonPage extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onStartQuiz;

  const LessonPage({
    super.key,
    required this.children,
    required this.onStartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: children,
          ),
        ),
        // Bottom action bar: solid, with a dark wood top border.
        Container(
          decoration: const BoxDecoration(
            color: AppColors.parchment,
            border: Border(
              top: BorderSide(color: AppColors.frame, width: 1),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onStartQuiz,
                  icon: const Icon(Icons.quiz_outlined),
                  label: const Text('Start Quiz'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Blue banner at the top of a lesson.
class LessonHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final List<String> badges;

  const LessonHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.badges = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.blueDeep, AppColors.blue, AppColors.plum],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.saffron,
                child: Icon(icon, color: AppColors.blueDeep, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.heading(size: 24, color: Colors.white),
                ),
              ),
            ],
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              subtitle!,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
          if (badges.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final b in badges)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
