import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// AppTextStyles: design.md ke "typography" section se liye gaye hain.
///
/// IMPORTANT: Real "Inter" font dikhane ke liye `google_fonts` package
/// use kar rahe hain — yeh Google ke servers se Inter font khud
/// download/cache kar leta hai, is liye humein manually .ttf files
/// project mein daalne ki zaroorat nahi padi. Isi wajah se "bold"
/// text pehle sahi bold nahi dikh raha tha — jab font hi load nahi
/// hua tha, uske weight variants (Semi Bold, Bold) bhi sahi render
/// nahi ho rahe thay.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _inter({
    required double fontSize,
    required FontWeight fontWeight,
    required double height, // line-height in px (Figma value)
    double letterSpacing = 0,
    Color color = AppColors.onSurface,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height / fontSize, // Flutter height multiplier = px / fontSize
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle get displayLg => _inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 40,
        letterSpacing: -0.02 * 32,
      );

  static TextStyle get headlineLg => _inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32,
        letterSpacing: -0.01 * 24,
      );

  static TextStyle get headlineMd => _inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 28,
      );

  static TextStyle get bodyLg => _inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24,
      );

  static TextStyle get bodyMd => _inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20,
        color: AppColors.onSurfaceVariant,
      );

  static TextStyle get labelLg => _inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20,
        letterSpacing: 0.01 * 14,
      );

  static TextStyle get labelSm => _inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16,
        color: AppColors.onSurfaceVariant,
      );

  static TextStyle get priceLg => _inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 24,
        color: AppColors.primary,
      );
}
