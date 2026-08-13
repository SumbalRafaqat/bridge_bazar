import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

/// SearchBarWidget: Home screen ka rounded search input
/// (Figma design.md: "prominent, rounded input field... containing
/// 'Search for milk, bread, etc.' placeholder").
class SearchBarWidget extends StatelessWidget {
  final String hint;
  final VoidCallback? onTap;
  final VoidCallback? onMicTap;

  const SearchBarWidget({
    super.key,
    this.hint = 'Search for milk, bread, etc.',
    this.onTap,
    this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm, vertical: AppDimensions.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          border: Border.all(color: AppColors.outlineVariant),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 1, offset: const Offset(0, 1))],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, size: 20, color: AppColors.onSurfaceVariant),
            const SizedBox(width: AppDimensions.xs),
            Expanded(
              child: Text(hint, style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant)),
            ),
            IconButton(
              icon: const Icon(Icons.mic_none_outlined, size: 18, color: AppColors.onSurfaceVariant),
              onPressed: onMicTap,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
