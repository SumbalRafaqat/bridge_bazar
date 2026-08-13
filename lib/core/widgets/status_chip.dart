import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

/// StatusChip: chhota pill-shaped badge — "LIMITED TIME", "Save Rs. 250",
/// "Fast Delivery" jaisi tags ke liye reusable (Figma design.md:
/// "Status Chips: Use secondary Warm Orange").
class StatusChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const StatusChip({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.secondaryContainer,
    this.textColor = AppColors.onSecondaryContainer,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xs, vertical: AppDimensions.base),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: AppDimensions.base),
          ],
          Text(label, style: AppTextStyles.labelSm.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
