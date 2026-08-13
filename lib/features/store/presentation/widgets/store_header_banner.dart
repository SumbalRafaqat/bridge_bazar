import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// StoreHeaderBanner: "Store Header (Bento-style Glassmorphism)"
/// (Figma 1:876) — background photo + blur overlay + store name,
/// rating pill, min-order pill.
///
/// Real store photo Figma ke temp CDN se hai (expire ho jaata), is
/// liye gradient placeholder use kiya — jab real image asset/URL
/// milay, Container ke andar Image.network() add kar dena.
class StoreHeaderBanner extends StatelessWidget {
  final String storeName;
  final double rating;
  final int minOrder;

  const StoreHeaderBanner({
    super.key,
    required this.storeName,
    required this.rating,
    required this.minOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd), // 12px
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primaryContainer.withOpacity(0.5), AppColors.primary],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const Positioned.fill(
            child: Center(child: Icon(Icons.storefront_rounded, size: 64, color: Colors.white24)),
          ),
          // Bottom gradient scrim so white text stays readable
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            left: AppDimensions.md,
            right: AppDimensions.md,
            bottom: AppDimensions.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(storeName, style: AppTextStyles.displayLg.copyWith(color: Colors.white)),
                const SizedBox(height: AppDimensions.xs),
                Row(
                  children: [
                    _GlassPill(child: Row(children: [
                      const Icon(Icons.star_rounded, size: 13, color: AppColors.secondaryContainer),
                      const SizedBox(width: AppDimensions.base),
                      Text('$rating', style: AppTextStyles.labelLg.copyWith(color: Colors.white)),
                    ])),
                    const SizedBox(width: AppDimensions.xs),
                    _GlassPill(child: Text('Min. Order Rs. $minOrder', style: AppTextStyles.labelLg.copyWith(color: Colors.white))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Chhota "glass" pill — semi-transparent white bg + border (Figma:
/// backdrop-blur + rgba(255,255,255,0.2)).
class _GlassPill extends StatelessWidget {
  final Widget child;
  const _GlassPill({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm, vertical: AppDimensions.base),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: child,
    );
  }
}
