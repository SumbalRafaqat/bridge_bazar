import 'package:flutter/material.dart';

/// AppColors: design.md ke "colors" section se liye gaye hain.
/// Yahan sirf COLORS define hote hain — poore app mein reuse hote hain.
/// Kabhi bhi kisi widget mein Color(0xFF...) hardcode NA karein,
/// hamesha AppColors.xxx use karein.
class AppColors {
  AppColors._(); // constructor private — is class ka object nahi banega

  static const Color primary = Color(0xFF006C49);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF10B981);
  static const Color onPrimaryContainer = Color(0xFF00422B);

  static const Color secondary = Color(0xFF855300);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFEA619);
  static const Color onSecondaryContainer = Color(0xFF684000);

  static const Color tertiary = Color(0xFF005AC2);
  static const Color onTertiary = Color(0xFFFFFFFF);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color background = Color(0xFFF8F9FF);
  static const Color onBackground = Color(0xFF121C2A);

  static const Color surface = Color(0xFFF8F9FF);
  static const Color surfaceDim = Color(0xFFD0DBED);
  static const Color surfaceBright = Color(0xFFF8F9FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEFF4FF);
  static const Color surfaceContainer = Color(0xFFE6EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDEE9FC);
  static const Color surfaceContainerHighest = Color(0xFFD9E3F6);

  static const Color onSurface = Color(0xFF121C2A);
  static const Color onSurfaceVariant = Color(0xFF3C4A42);

  static const Color outline = Color(0xFF6C7A71);
  static const Color outlineVariant = Color(0xFFBBCABF);
}
