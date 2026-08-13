import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// RoleSelectionCard: "Join as a Shopper" / "Join as a Seller" card
/// (Figma: "Button - Shopper Card" / "Button - Seller Card", 1:81 & 1:93).
/// Reusable hai — sirf icon, title, description, aur icon-bg-color
/// alag diye jaate hain, taake dono cards isi widget se banein.
class RoleSelectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  const RoleSelectionCard({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg), // 16px
        child: Container(
          height: 142,
          padding: const EdgeInsets.all(AppDimensions.lg), // 24px
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest.withOpacity(0.9),
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            border: Border.all(color: AppColors.surfaceContainerHighest),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Icon bubble (56x56, radius 12) =====
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd), // 12px
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: AppDimensions.md), // 16px
              // ===== Title + Description =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface),
                    ),
                    const SizedBox(height: AppDimensions.base), // 4px
                    Text(
                      description,
                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              // ===== Trailing arrow =====
              Padding(
                padding: const EdgeInsets.only(top: AppDimensions.base * 5), // vertically centered-ish
                child: Icon(Icons.arrow_forward, size: 16, color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
