import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/category_model.dart';

/// CategoryGrid: "Explore Categories" — 4 icons ka row
/// (Figma: Fruits & Veg, Dairy, Meat, Snacks).
class CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel>? onCategoryTap;

  const CategoryGrid({super.key, required this.categories, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categories.map((category) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.base),
            child: InkWell(
              onTap: () => onCategoryTap?.call(category),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppDimensions.sm),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd), // 12px
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(color: AppColors.surfaceContainerLow, shape: BoxShape.circle),
                      child: Icon(category.icon, size: 22, color: AppColors.primary),
                    ),
                    const SizedBox(height: AppDimensions.xs),
                    Text(
                      category.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
