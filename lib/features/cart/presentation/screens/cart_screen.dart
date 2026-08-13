import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../data/models/cart_item_model.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

/// CartScreen: Figma "My Cart" (1:968) se EXACT match.
/// Header (back + title + delete/clear icon) → "My Cart (N Items)" →
/// Cart item cards → Promo Code row → Order Summary card
/// (Subtotal/Delivery/Discount/Total + Proceed to Checkout) →
/// Bottom Nav Bar (Cart active).
///
/// Delivery fee (Rs. 150) abhi FIXED hai (Figma ke mutabiq) — jab
/// real delivery-distance logic aayegi, isay dynamic bana denge.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const int _deliveryFee = 150;
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      // ===== Header - TopAppBar (1:994) =====
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.maybePop(context),
        ),
        centerTitle: true,
        title: Text('BazaarBridge', style: AppTextStyles.headlineLg.copyWith(color: AppColors.primary)),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.onSurface),
                onPressed: state.items.isEmpty
                    ? null
                    : () => context.read<CartBloc>().add(const CartCleared()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 56, color: AppColors.outlineVariant),
                  const SizedBox(height: AppDimensions.md),
                  Text('Your cart is empty', style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            );
          }

          final subtotal = state.totalPrice;
          const discount = 0; // TODO: promo code logic se yeh dynamic hoga
          final total = subtotal + _deliveryFee - discount;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ===== "My Cart (N Items)" heading (1:1008) =====
                Text(
                  'My Cart (${state.totalItems} Items)',
                  style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface),
                ),
                const SizedBox(height: AppDimensions.md),

                // ===== Cart Item Cards (1:1009 / 1:1033 / 1:1057) =====
                ...state.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppDimensions.md),
                      child: _CartItemCard(item: item),
                    )),
                const SizedBox(height: AppDimensions.xs),

                // ===== Promo Code (1:1079) =====
                Container(
                  padding: const EdgeInsets.all(AppDimensions.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _promoController,
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          decoration: InputDecoration(
                            hintText: 'Enter Promo Code',
                            hintStyle: AppTextStyles.bodyMd,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusDefault),
                              borderSide: const BorderSide(color: AppColors.outlineVariant),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.sm),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: promo code validate karne wala API call yahan aayega.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Promo code feature coming soon')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceContainerHigh,
                            foregroundColor: AppColors.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusDefault)),
                          ),
                          child: Text('Apply', style: AppTextStyles.labelLg.copyWith(color: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.md),

                // ===== Order Summary Card (1:1085) =====
                Container(
                  padding: const EdgeInsets.all(AppDimensions.sm + 1),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppDimensions.sm),
                        child: Text('Order Summary', style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
                      ),
                      _SummaryRow(label: 'Subtotal (${state.totalItems} items)', value: 'Rs. $subtotal'),
                      const SizedBox(height: AppDimensions.xs),
                      const _SummaryRow(label: 'Delivery Fee', value: 'Rs. $_deliveryFee'),
                      const SizedBox(height: AppDimensions.xs),
                      _SummaryRow(label: 'Discount Applied', value: '- Rs. $discount', color: AppColors.primary),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppDimensions.sm),
                        child: Divider(color: AppColors.outlineVariant, height: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
                          Text('Rs. $total', style: AppTextStyles.priceLg),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.md),

                      // ===== Proceed to Checkout button (1:1112) =====
                      SizedBox(
                        height: AppDimensions.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Checkout screen banne par yahan navigate karna.
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusFull)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Proceed to Checkout', style: AppTextStyles.labelLg.copyWith(color: AppColors.onPrimary)),
                              const SizedBox(width: AppDimensions.xs),
                              const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: AppBottomNavBar(currentIndex: 2, onTap: (i) => AppRouter.navigateToTab(context, i)),
    );
  }
}

/// Ek cart item card — image + naam/variant + price + (badge?) + quantity selector.
class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.sm + 1),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 1, offset: const Offset(0, 1))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder (real photo Figma temp-CDN se hai, expire ho jaata)
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(color: AppColors.surfaceContainer, borderRadius: BorderRadius.circular(AppDimensions.radiusDefault)),
            child: const Icon(Icons.image_outlined, color: AppColors.outline),
          ),
          const SizedBox(width: AppDimensions.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)),
                          if (item.variant != null)
                            Text(item.variant!, style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    Text('Rs. ${item.price}', style: AppTextStyles.priceLg),
                  ],
                ),
                const SizedBox(height: AppDimensions.xs),
                Row(
                  mainAxisAlignment: item.badgeLabel != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                  children: [
                    if (item.badgeLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xs, vertical: AppDimensions.base),
                        decoration: BoxDecoration(
                          color: item.badgeColor ?? AppColors.secondaryContainer,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                        ),
                        child: Text(
                          item.badgeLabel!,
                          style: AppTextStyles.labelSm.copyWith(color: item.badgeTextColor ?? AppColors.onSecondaryContainer),
                        ),
                      ),
                    QuantitySelector(
                      quantity: item.quantity,
                      onChanged: (qty) => context.read<CartBloc>().add(
                            CartItemQuantityChanged(productId: item.productId, quantity: qty),
                          ),
                    ),
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _SummaryRow({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodyMd.copyWith(color: color ?? AppColors.onSurfaceVariant);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(value, style: style)],
    );
  }
}
