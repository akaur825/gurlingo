import 'package:flutter/material.dart';
import '../widgets/progress_circle.dart';
import '../services/app_state.dart';
import '../models/user_progress.dart';
import '../data/lesson_data.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser ?? UserProgress(username: "Guest");
    // Curriculum sizes come from the lesson lists: 12 Sur (7 Shudh + 5 Vakrit), 11 Raag.
    final surIds = {for (final l in [...surLessons, ...vakritSurLessons]) l.id};
    final raagIds = {for (final l in raagLessons) l.id};
    final surTotal = surIds.length;
    final raagTotal = raagIds.length;
    final surDone = user.completedSurLessons.where(surIds.contains).toSet().length;
    final raagDone = user.completedRaagLessons.where(raagIds.contains).toSet().length;
    final totalLessons = surDone + raagDone;
    final currentScale = user.preferredScale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header + sign out
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ਵਾਹਿਗੁਰੂ ਜੀ ਕਾ ਖਾਲਸਾ ਵਾਹਿਗੁਰੂ ਜੀ ਕੀ ਫਤਿਹ",
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.wood,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Welcome, ${user.username}",
                          style: AppTheme.heading(size: 28, color: AppColors.blueDeep),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Sign out',
                    icon: const Icon(Icons.logout, color: AppColors.wood),
                    onPressed: _confirmSignOut,
                  ),
                ],
              ),

              const SizedBox(height: 16),
              _scaleSelector(currentScale),
              const SizedBox(height: 20),

              // Stats
              Row(
                children: [
                  Expanded(
                    child: _statCard(Icons.local_fire_department,
                        user.streakDays.toString(), "Day Streak", AppColors.saffron),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _statCard(Icons.flash_on, user.totalXp.toString(),
                        "Total XP", AppColors.plum),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _statCard(Icons.emoji_events, totalLessons.toString(),
                        "Lessons", AppColors.blue),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Progress
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: AppTheme.card(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Progress", style: AppTheme.heading(size: 20)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _progressColumn("Sur", surDone, surTotal, Icons.mic),
                        _progressColumn(
                            "Raag", raagDone, raagTotal, Icons.music_note),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to Sign Out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await AppState.logout();
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              }
            },
            child: const Text("Sign Out", style: TextStyle(color: AppColors.bad)),
          ),
        ],
      ),
    );
  }

  // Two equal halves, so the labels never overflow on a narrow phone.
  Widget _scaleSelector(String currentScale) {
    Widget option(String scale, String label) {
      final selected = currentScale == scale;
      return Expanded(
        child: GestureDetector(
          onTap: () async {
            await AppState.updateScale(scale);
            if (mounted) setState(() {});
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: selected ? AppColors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : AppColors.inkSoft,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          option('C#', 'Male Scale (C#)'),
          option('G#', 'Female Scale (G#)'),
        ],
      ),
    );
  }

  Widget _progressColumn(String label, int done, int total, IconData icon) {
    return Column(
      children: [
        ProgressCircle(progress: total == 0 ? 0 : done / total, icon: icon),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        Text("$done/$total", style: const TextStyle(color: AppColors.inkSoft)),
      ],
    );
  }

  Widget _statCard(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      decoration: AppTheme.card(radius: 18),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, style: AppTheme.heading(size: 22)),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label, style: const TextStyle(color: AppColors.inkSoft)),
          ),
        ],
      ),
    );
  }
}
