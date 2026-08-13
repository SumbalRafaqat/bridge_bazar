import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

/// QuantitySelector: "− 1 +" wala compact component
/// (design.md: "Quantity Selector... using the primary color for the
/// icons"). Jab quantity 0 ho, humne ProductCard ka simple "+" button
/// dikhaya (add karne ke liye); jaise hi quantity >= 1 ho jaye, yeh
/// widget uski jagah dikhta hai.
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantitySelector({super.key, required this.quantity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(icon: Icons.remove, onTap: () => onChanged(quantity - 1)),
          SizedBox(
            width: 20,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface),
            ),
          ),
          _QtyButton(icon: Icons.add, onTap: () => onChanged(quantity + 1)),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      child: SizedBox(
        width: 32,
        height: 32,
        child: Icon(icon, size: 14, color: AppColors.onSurface),
      ),
    );
  }
}
