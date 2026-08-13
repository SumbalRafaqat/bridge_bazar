import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../data/models/promo_banner_model.dart';

/// PromoBannerCarousel: "Flat 20% Off" jaisi green banner
/// (Figma: "Section - Promo Banner Carousel", 160px height).
class PromoBannerCarousel extends StatelessWidget {
  final List<PromoBannerModel> banners;

  const PromoBannerCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 160,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            padding: const EdgeInsets.all(AppDimensions.lg), // 24px
            decoration: BoxDecoration(
              color: AppColors.primaryContainer, // #10B981
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd), // 12px
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusChip(
                        label: banner.badgeText,
                        backgroundColor: AppColors.secondaryContainer,
                        textColor: AppColors.onSecondaryContainer,
                      ),
                      const SizedBox(height: AppDimensions.sm),
                      Text(
                        banner.titleLine1,
                        style: AppTextStyles.headlineMd.copyWith(color: AppColors.onPrimaryContainer),
                      ),
                      Text(
                        banner.titleLine2,
                        style: AppTextStyles.headlineMd.copyWith(color: AppColors.onPrimaryContainer),
                      ),
                    ],
                  ),
                ),
                // Illustration placeholder (Figma: fresh groceries photo)
                const Icon(Icons.local_grocery_store_rounded, size: 56, color: Colors.white70),
              ],
            ),
          );
        },
      ),
    );
  }
}
