import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// SocialAuthButtons: "Google" aur "Apple" buttons ka row.
/// Figma mein asal Google/Apple logos (SVG) hain, lekin woh Figma ke
/// temporary CDN se aate hain (7 din baad expire ho jate). Is liye
/// yahan Icon use kiya hai — jab aap apne project mein real
/// google_logo.png / apple_logo.png assets daalengi, Icon() ko
/// Image.asset() se replace kar dena.
///
/// borderRadius PARAMETER hai kyunke Figma mein Login screen ke social
/// buttons "pill" shape (radius 9999) hain, jabke Signup screen ke
/// "rounded box" (radius 8) hain — exact match ke liye.
class SocialAuthButtons extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;
  final double borderRadius;

  const SocialAuthButtons({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.borderRadius = AppDimensions.radiusFull,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SocialButton(
          label: 'Google',
          icon: Icons.g_mobiledata_rounded, // TODO: replace with real Google logo asset
          borderRadius: borderRadius,
          onPressed: onGooglePressed,
        )),
        const SizedBox(width: AppDimensions.md), // 16px gap (Figma)
        Expanded(child: _SocialButton(
          label: 'Apple',
          icon: Icons.apple,
          borderRadius: borderRadius,
          onPressed: onApplePressed,
        )),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final double borderRadius;
  final VoidCallback? onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.borderRadius,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.buttonHeight, // 48px
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surfaceContainerLowest,
          side: const BorderSide(color: AppColors.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.onSurface),
            const SizedBox(width: AppDimensions.base * 2),
            Text(
              label,
              style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
