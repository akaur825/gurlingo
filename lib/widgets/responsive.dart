// lib/widgets/responsive.dart
//
// Keeps the app a comfortable reading width on tablets and desktop windows.

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Widest the app column gets. Phones are narrower, so they are unaffected.
const double kMaxContentWidth = 720;

/// Wraps the whole app (MaterialApp.builder): on a wide window the app sits in
/// a centred column with a slightly darker parchment on each side.
class AppFrame extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const AppFrame({super.key, required this.child, this.maxWidth = kMaxContentWidth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= maxWidth) return child;
        // Side pillars: lighter than the page, with a soft fade toward the
        // centre column, which has a thin border and a gentle shadow.
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFAEE),
                Color(0xFFFBF1DA),
                Color(0xFFFFFAEE),
              ],
            ),
          ),
          child: Center(
            child: SizedBox(
              width: maxWidth,
              height: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: const Border.symmetric(
                    vertical: BorderSide(color: AppColors.border, width: 1.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.wood.withValues(alpha: 0.18),
                      blurRadius: 28,
                    ),
                  ],
                ),
                child: ClipRect(child: child),
              ),
            ),
          ),
        );
      },
    );
  }
}
