import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../data/datasources/store_remote_datasource.dart';
import '../../data/repositories/store_repository_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_store_products_usecase.dart';
import '../bloc/store_bloc.dart';
import '../bloc/store_event.dart';
import '../bloc/store_state.dart';
import '../widgets/store_header_banner.dart';

/// StoreProductsScreen: Figma "Store Products" (1:831) se EXACT match.
/// StoreHeaderBanner → Search-in-store → "Popular Items" 2-col grid
/// (har card ka apna "+"/quantity-selector state, CartBloc se live) →
/// Floating "View Cart" bar (jab cart mein kuch ho) → Bottom Nav Bar.
class StoreProductsScreen extends StatelessWidget {
  final String storeId;
  final String storeName;

  const StoreProductsScreen({super.key, required this.storeId, this.storeName = 'Green Valley Store'});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreBloc(
        getStoreProductsUseCase: GetStoreProductsUseCase(StoreRepositoryImpl(StoreRemoteDataSource())),
      )..add(StoreProductsRequested(storeId)),
      child: _StoreView(storeName: storeName),
    );
  }
}

class _StoreView extends StatelessWidget {
  final String storeName;
  const _StoreView({required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      // ===== Header - TopAppBar (1:853) =====
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('BazaarBridge', style: AppTextStyles.headlineLg.copyWith(color: AppColors.primary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppColors.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              if (state is StoreLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }
              if (state is StoreError) {
                return Center(child: Text(state.message, style: AppTextStyles.bodyLg.copyWith(color: AppColors.error)));
              }

              final products = (state as StoreLoaded).products;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(AppDimensions.md, AppDimensions.lg, AppDimensions.md, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ===== Store Header Banner (1:876) =====
                    StoreHeaderBanner(storeName: storeName, rating: 4.8, minOrder: 500),
                    const SizedBox(height: AppDimensions.xs),

                    // ===== Search within Store (1:892) =====
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.sm, vertical: AppDimensions.sm),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 18, color: AppColors.onSurfaceVariant),
                          const SizedBox(width: AppDimensions.xs),
                          Expanded(
                            child: Text(
                              'Search for milk, bread, etc. in $storeName',
                              style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.md),

                    // ===== "Popular Items" heading (1:899) =====
                    Text('Popular Items', style: AppTextStyles.headlineMd.copyWith(color: AppColors.onSurface)),
                    const SizedBox(height: AppDimensions.md),

                    // ===== Product Grid (1:901) =====
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppDimensions.md,
                        crossAxisSpacing: AppDimensions.md,
                        childAspectRatio: 0.82,
                      ),
                      itemBuilder: (context, i) => _StoreProductCard(product: products[i]),
                    ),
                  ],
                ),
              );
            },
          ),

          // ===== Floating "View Cart" button (1:862) =====
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (cartState.items.isEmpty) return const SizedBox.shrink();
              return Positioned(
                left: AppDimensions.md,
                right: AppDimensions.md,
                bottom: AppDimensions.md,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())),
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.lg),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 10))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                              child: Center(
                                child: Text('${cartState.totalItems}', style: AppTextStyles.labelLg.copyWith(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: AppDimensions.sm),
                            Text('Items', style: AppTextStyles.labelLg.copyWith(color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Rs. ${cartState.totalPrice}', style: AppTextStyles.priceLg.copyWith(color: Colors.white)),
                            const SizedBox(width: AppDimensions.sm),
                            const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(currentIndex: 0, onTap: (i) {}),
    );
  }
}

/// Ek product card jo CartBloc dekh kar decide karta hai: agar quantity
/// 0 hai to "+" gol button dikhao, warna QuantitySelector ("− n +").
class _StoreProductCard extends StatelessWidget {
  final ProductEntity product;
  const _StoreProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image placeholder + badge
          Stack(
            children: [
              Container(
                height: 128,
                color: AppColors.surfaceContainerLow,
                child: const Center(child: Icon(Icons.image_outlined, size: 28, color: AppColors.outline)),
              ),
              if (product.badge == ProductBadge.fastDelivery)
                const Positioned(top: AppDimensions.xs, left: AppDimensions.xs, child: StatusChip(label: 'Fast Delivery')),
              if (product.badge == ProductBadge.inStock)
                Positioned(
                  top: AppDimensions.xs,
                  left: AppDimensions.xs,
                  child: StatusChip(
                    label: 'In Stock',
                    backgroundColor: AppColors.surfaceContainerHigh,
                    textColor: AppColors.onSurface,
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelLg.copyWith(color: AppColors.onSurface),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rs. ${product.price}', style: AppTextStyles.priceLg),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, cartState) {
                          final qty = cartState.quantityOf(product.id);
                          if (qty == 0) {
                            return InkWell(
                              onTap: () => context.read<CartBloc>().add(
                                    CartItemAdded(productId: product.id, name: product.name, price: product.price),
                                  ),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
                                child: const Icon(Icons.add, size: 16, color: Colors.white),
                              ),
                            );
                          }
                          return QuantitySelector(
                            quantity: qty,
                            onChanged: (newQty) => context.read<CartBloc>().add(
                                  CartItemQuantityChanged(productId: product.id, quantity: newQty),
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
