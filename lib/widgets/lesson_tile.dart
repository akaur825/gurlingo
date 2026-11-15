import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// One row in the Sur / Raag lesson lists: done, current, or locked.
class LessonTile extends StatelessWidget {
  final String title;
  final bool completed;
  final bool unlocked;
  final VoidCallback? onTap;

  const LessonTile({
    super.key,
    required this.title,
    required this.completed,
    required this.unlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color border;
    final double borderWidth;
    final Color badge;
    final Color iconColor;
    final Color textColor;
    final IconData icon;
    List<BoxShadow>? shadow;

    if (completed) {
      // Warm sage
      bg = const Color(0xFFE3ECDF);
      border = const Color(0xFF5F8D62);
      borderWidth = 1.5;
      badge = const Color(0xFF2E6B38);
      iconColor = Colors.white;
      textColor = AppColors.ink;
      icon = Icons.check_rounded;
    } else if (unlocked) {
      // Current lesson: saffron glow
      bg = const Color(0xFFFDEBC8);
      border = AppColors.saffron;
      borderWidth = 2;
      badge = AppColors.saffron;
      iconColor = AppColors.blue;
      textColor = AppColors.ink;
      icon = Icons.play_arrow_rounded;
      shadow = [
        BoxShadow(
          color: AppColors.saffron.withValues(alpha: 0.38),
          blurRadius: 16,
          offset: const Offset(0, 5),
        ),
      ];
    } else {
      // Locked: translucent sand
      bg = const Color(0xFFF8F4EC);
      border = const Color(0xFFD8CCB8);
      borderWidth = 1;
      badge = const Color(0xFFEBE4D6);
      iconColor = const Color(0xFF8C7D6B);
      textColor = const Color(0xFF8C7D6B);
      icon = Icons.lock_outline;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: unlocked ? onTap : null,
          child: Ink(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: border, width: borderWidth),
              boxShadow: shadow,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: badge,
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: unlocked && !completed
                          ? FontWeight.w800
                          : FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
