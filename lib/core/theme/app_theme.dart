import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'app_text_styles.dart';

/// AppTheme: MaterialApp ke "theme:" property mein use hoga.
/// Is se buttons, inputs, scaffold background, sab jagah
/// automatically same colors/fonts apply ho jaate hain.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      // GoogleFonts.interTextTheme() poori app ke DEFAULT text ko
      // (jaise wo Text() widgets jo humari custom AppTextStyles use
      // nahi kar rahe) bhi real Inter font deta hai — fallback safe.
      textTheme: GoogleFonts.interTextTheme(),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        error: AppColors.error,
        onError: AppColors.onError,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
          textStyle: AppTextStyles.labelLg,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
