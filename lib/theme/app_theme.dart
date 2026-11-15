// lib/theme/app_theme.dart
//
// One place for the app's colours, fonts and default widget styles.
// Colours come from the Gurlingo logo: saffron and royal blue, with plum and
// wood-brown accents on warm parchment.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color saffron = Color(0xFFF5A623);
  static const Color saffronSoft = Color(0xFFFDEBC8);
  static const Color blue = Color(0xFF1F4FA3);
  static const Color blueDeep = Color(0xFF16316B);
  static const Color plum = Color(0xFF5B3A8C);
  static const Color wood = Color(0xFF7A4B24);

  static const Color parchment = Color(0xFFF1E2C0); // page background (antique parchment)
  static const Color cream = Color(0xFFFFFBF2); // cards
  static const Color border = Color(0xFFD9C397);
  static const Color ink = Color(0xFF2B2118); // main text
  static const Color frame = Color(0xFF7A5C39); // dark wood border for bars
  static const Color inkSoft = Color(0xFF6B5A47); // secondary text

  static const Color good = Color(0xFF2E7D4F);
  static const Color goodSoft = Color(0xFFE3F2E6);
  static const Color bad = Color(0xFFB3382C);
  static const Color badSoft = Color(0xFFFBE4E0);
}

class AppTheme {
  AppTheme._();

  /// Tests switch this off so no font is downloaded.
  static bool useGoogleFonts = true;

  /// Headings: Lora (serif).
  static TextStyle heading({
    double size = 22,
    FontWeight weight = FontWeight.w700,
    Color color = AppColors.ink,
  }) {
    final base = TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.2,
    );
    return useGoogleFonts ? GoogleFonts.lora(textStyle: base) : base;
  }

  /// Soft card shadow used across the app.
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: AppColors.wood.withValues(alpha: 0.10),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ];

  /// Standard cream card with border and shadow.
  static BoxDecoration card({Color? color, double radius = 20}) => BoxDecoration(
        color: color ?? AppColors.cream,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.border),
        boxShadow: softShadow,
      );

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.blue,
      onPrimary: Colors.white,
      secondary: AppColors.saffron,
      onSecondary: AppColors.blueDeep,
      tertiary: AppColors.plum,
      surface: AppColors.cream,
      onSurface: AppColors.ink,
      outline: AppColors.border,
      error: AppColors.bad,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.parchment,
    );

    TextTheme text = base.textTheme.apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );
    if (useGoogleFonts) {
      text = GoogleFonts.nunitoTextTheme(text);
      TextStyle? lora(TextStyle? s) =>
          s == null ? null : GoogleFonts.lora(textStyle: s);
      text = text.copyWith(
        displayLarge: lora(text.displayLarge),
        displayMedium: lora(text.displayMedium),
        displaySmall: lora(text.displaySmall),
        headlineLarge: lora(text.headlineLarge),
        headlineMedium: lora(text.headlineMedium),
        headlineSmall: lora(text.headlineSmall),
        titleLarge: lora(text.titleLarge),
      );
    }

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    );

    // Heavier weights across the board so text never looks thin on parchment.
    text = text.copyWith(
      bodyLarge: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      bodyMedium: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      bodySmall: text.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      titleSmall: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      labelLarge: text.labelLarge?.copyWith(fontWeight: FontWeight.w700),
    );

    return base.copyWith(
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.parchment,
        foregroundColor: AppColors.blueDeep,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: const Border(
          bottom: BorderSide(color: AppColors.frame, width: 1),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.blue),
        titleTextStyle: heading(size: 22, color: AppColors.blueDeep),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.saffron,
          foregroundColor: AppColors.blueDeep,
          disabledBackgroundColor: AppColors.border,
          disabledForegroundColor: AppColors.inkSoft,
          minimumSize: const Size(64, 54),
          elevation: 3,
          shadowColor: AppColors.wood.withValues(alpha: 0.35),
          shape: buttonShape,
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue,
          minimumSize: const Size(64, 54),
          side: const BorderSide(color: AppColors.blue, width: 2),
          shape: buttonShape,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.blue),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cream,
        floatingLabelStyle: const TextStyle(color: AppColors.blue),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.blue, width: 2),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.saffron,
        linearTrackColor: AppColors.border,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cream,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.inkSoft,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.cream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.blueDeep,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border),
    );
  }
}
