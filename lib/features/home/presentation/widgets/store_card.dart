import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../data/models/store_preview_model.dart';

/// StoreCard: "Stores Near You" section ka ek card
/// (Figma: FreshMart Superstore, Green Valley Grocers).
class StoreCard extends StatelessWidget {
  final StorePreviewModel store;
  final VoidCallback? onTap;

  const StoreCard({super.key, required this.store, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(color: AppColors.surfaceContainerHigh),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image placeholder
            Stack(
              children: [
                Container(
                  height: 128,
                  color: AppColors.surfaceContainerLow,
                  child: const Center(child: Icon(Icons.storefront_outlined, size: 32, color: AppColors.outline)),
                ),
                if (store.isFastDelivery)
                  const Positioned(
                    top: AppDimensions.xs,
                    left: AppDimensions.xs,
                    child: StatusChip(label: 'Fast Delivery', icon: Icons.bolt),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.name, style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
                  const SizedBox(height: AppDimensions.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: AppColors.secondaryContainer),
                          const SizedBox(width: AppDimensions.base),
                          Text(
                            '${store.rating} (${store.reviewCount}+)',
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.place_outlined, size: 14, color: AppColors.onSurfaceVariant),
                          const SizedBox(width: AppDimensions.base),
                          Text(
                            '${store.distanceKm} km',
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xs, vertical: AppDimensions.base),
                    decoration: BoxDecoration(
                      color: store.isFastDelivery ? AppColors.surfaceContainerLow : AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(6),
                      border: store.isFastDelivery ? null : Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, size: 12, color: AppColors.primary),
                        const SizedBox(width: AppDimensions.base),
                        Text(
                          '${store.etaMinutes} min',
                          style: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
