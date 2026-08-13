import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import 'status_chip.dart';

/// ProductCard: image-heavy card jisme price bottom-left aur floating
/// "+" quick-add button bottom-right hota hai (Figma design.md:
/// "Product Cards: Image-heavy... floating '+' icon... Quick Add").
/// "Deals of the Week" section isay use karta hai — aage Store Products
/// screen bhi isi widget ko reuse karegi.
///
/// imageUrl abhi use nahi ho raha (Figma temp URLs expire ho jaate),
/// is liye ek color placeholder box + icon dikha rahe hain. Jab real
/// product images ka backend mile, ek Image.network(imageUrl) add kar
/// dena is Container ke andar.
class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final int? originalPrice;
  final String? badgeLabel; // "Save Rs. 250"
  final VoidCallback? onAddPressed;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.originalPrice,
    this.badgeLabel,
    this.onAddPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd), // 12px
          border: Border.all(color: AppColors.surfaceContainerHigh),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== Image area (placeholder) =====
            Stack(
              children: [
                Container(
                  height: 128,
                  color: AppColors.surfaceContainerLow,
                  child: const Center(
                    child: Icon(Icons.image_outlined, size: 32, color: AppColors.outline),
                  ),
                ),
                if (badgeLabel != null)
                  Positioned(top: AppDimensions.xs, left: AppDimensions.xs, child: StatusChip(label: badgeLabel!)),
              ],
            ),
            // ===== Info area =====
            Padding(
              padding: const EdgeInsets.all(AppDimensions.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface),
                  ),
                  const SizedBox(height: AppDimensions.xs),
                  Row(
                    children: [
                      Text('Rs. $price', style: AppTextStyles.priceLg),
                      if (originalPrice != null) ...[
                        const SizedBox(width: AppDimensions.xs),
                        Text(
                          'Rs. $originalPrice',
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.onSurfaceVariant,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppDimensions.xs),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: onAddPressed,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(Icons.add, color: AppColors.onPrimary, size: 18),
                      ),
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
