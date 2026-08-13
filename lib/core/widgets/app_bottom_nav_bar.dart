import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

/// AppBottomNavBar: poore app mein reusable bottom navigation
/// (Home, Categories, Cart, Profile) — Figma: "BottomNavBar (Mobile Only)".
/// Active tab par green "pill" background hota hai.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  static const _items = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.grid_view_rounded, label: 'Categories'),
    (icon: Icons.shopping_cart_outlined, label: 'Cart'),
    (icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.xl * 2.5, // 80px
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm, vertical: AppDimensions.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer, // #E6EEFF
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusMd),
          topRight: Radius.circular(AppDimensions.radiusMd),
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, -4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_items.length, (i) {
          final isActive = i == currentIndex;
          final item = _items[i];
          return InkWell(
            onTap: () => onTap(i),
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.md, vertical: AppDimensions.base),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryContainer : Colors.transparent,
                borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 20, color: isActive ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant),
                  const SizedBox(height: AppDimensions.base),
                  Text(
                    item.label,
                    style: AppTextStyles.labelSm.copyWith(
                      color: isActive ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
