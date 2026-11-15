import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Parchment page background with a faint jaali (lattice) pattern.
/// Wrap a whole `Scaffold` (with `backgroundColor: Colors.transparent`) in it.
class ParchmentBackground extends StatelessWidget {
  final Widget child;

  const ParchmentBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.parchment),
        const RepaintBoundary(
          child: CustomPaint(painter: _JaaliPainter()),
        ),
        child,
      ],
    );
  }
}

/// Diamond lattice with a small eight-petal flower where the lines cross.
/// Very low opacity so text contrast is not affected.
class _JaaliPainter extends CustomPainter {
  const _JaaliPainter();

  static const double _cell = 64;

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.wood.withValues(alpha: 0.07);
    final petal = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.saffron.withValues(alpha: 0.13);

    final cols = (size.width / _cell).ceil() + 1;
    final rows = (size.height / _cell).ceil() + 1;
    const half = _cell / 2;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final cx = c * _cell + half;
        final cy = r * _cell + half;

        // Diamond around the cell centre; neighbours share edges -> lattice.
        final diamond = Path()
          ..moveTo(cx, cy - half)
          ..lineTo(cx + half, cy)
          ..lineTo(cx, cy + half)
          ..lineTo(cx - half, cy)
          ..close();
        canvas.drawPath(diamond, line);

        // Inner circle and four petals.
        canvas.drawCircle(Offset(cx, cy), 5, petal);
        for (var i = 0; i < 4; i++) {
          canvas.save();
          canvas.translate(cx, cy);
          canvas.rotate(i * 3.14159265 / 2);
          canvas.drawOval(
            Rect.fromCenter(center: const Offset(0, -12), width: 9, height: 16),
            petal,
          );
          canvas.restore();
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A Scaffold that sits on the parchment + jaali background.
class PatternScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  const PatternScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return ParchmentBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
