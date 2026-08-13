import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

/// Kaunsa button style chahiye — Figma mein 2 tarah ke buttons dikhe:
/// 1. primary  → Green filled, "Log In" / "Create Account" jaisi buttons
/// 2. outline  → White bg + border, "Google" / "Apple" jaisi buttons
enum CustomButtonType { primary, outline }

/// CustomButton: poore app mein reusable button.
/// isLoading true karne se button ke andar spinner dikhta hai
/// (jab BLoC API call kar raha ho, tab useful hoga).
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonType type;
  final Widget? icon;
  final bool isLoading;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = CustomButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.borderRadius = AppDimensions.radiusFull, // pill shape default
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: AppDimensions.xs)],
              Text(text),
            ],
          );

    if (type == CustomButtonType.primary) {
      return SizedBox(
        height: AppDimensions.buttonHeight, // 48px (Figma)
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            textStyle: AppTextStyles.labelLg.copyWith(color: AppColors.onPrimary),
          ),
          child: child,
        ),
      );
    }

    // Outline (Google / Apple) button
    return SizedBox(
      height: AppDimensions.buttonHeight,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surfaceContainerLowest, // white
          foregroundColor: AppColors.onSurface,
          side: const BorderSide(color: AppColors.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface),
        ),
        child: child,
      ),
    );
  }
}
