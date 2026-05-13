import 'package:flutter/material.dart';
import 'dart:math';

class ProgressCircle extends StatelessWidget {
  final double progress; // 0 → 1
  final IconData icon;

  const ProgressCircle({
    super.key,
    required this.progress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 🔘 BACKGROUND CIRCLE (THIS WAS MISSING)
          CustomPaint(
            size: const Size(120, 120),
            painter: CirclePainter(
              progress: 1,
              color: Colors.grey.shade300,
            ),
          ),

          // 🟠 PROGRESS ARC
          CustomPaint(
            size: const Size(120, 120),
            painter: CirclePainter(
              progress: progress,
              color: Colors.orange,
            ),
          ),

          // 🎯 CENTER ICON
          Icon(icon, color: Colors.orange, size: 30),
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

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}