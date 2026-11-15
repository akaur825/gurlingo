import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/app_theme.dart';

class ProgressCircle extends StatelessWidget {
  final double progress; // 0 → 1
  final IconData icon;
  final double size;

  const ProgressCircle({
    super.key,
    required this.progress,
    required this.icon,
    this.size = 110,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: CirclePainter(progress: 1, color: AppColors.border),
          ),
          CustomPaint(
            size: Size(size, size),
            painter: CirclePainter(
              progress: progress.clamp(0.0, 1.0),
              color: AppColors.saffron,
            ),
          ),
          Icon(icon, color: AppColors.blue, size: 30),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final Color color;

  CirclePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = color;

    // Inset by half the stroke so the ring is not clipped at the edges.
    canvas.drawArc(
      Rect.fromLTWH(5, 5, size.width - 10, size.height - 10),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
